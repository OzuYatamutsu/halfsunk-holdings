class_name BuySellModal
extends Modal

enum Mode {
    BUY,
    SELL
}

var stock: Stock
var ticker: String = ""
var action: Mode = Mode.BUY

# "Jinhai Holdings (JINH)"
@onready var TickerLabel: Label = $ModalWindow/InfoContainer/TickerLabel

# "100.24"
@onready var ValueLabel: Label = $ModalWindow/InfoContainer/ValueContainer/ValueLabel

# (up or down symbol)
@onready var UpDownLabel: Label = $ModalWindow/InfoContainer/ValueContainer/UpDownLabel

# "1.64"
@onready var NetChangeValueLabel: Label = $ModalWindow/InfoContainer/ValueContainer/NetChangeValueLabel

# "(+2.64%)"
@onready var NetChangePercentLabel: Label = $ModalWindow/InfoContainer/ValueContainer/NetChangePercentLabel

# Buy/Sell button group
@onready var BuyButton: TextureButton = $ModalWindow/InfoContainer/BuySellButtonGroup/BuyButton
@onready var SellButton: TextureButton = $ModalWindow/InfoContainer/BuySellButtonGroup/SellButton

# Buy/Sell quantity group
@onready var QuantityEdit: LineEdit = $ModalWindow/InfoContainer/QuantitySelector/QuantityEdit
@onready var TickerEdit: LineEdit = $ModalWindow/InfoContainer/QuantitySelector/TickerEdit

@onready var ForATotalValueOfLabel: Label = $ModalWindow/InfoContainer/TotalInfo/ForATotalValueOfLabel
# "$12,345.00"
@onready var TransactionValueLabel: Label = $ModalWindow/InfoContainer/TotalInfo/TransactionValueLabel
@onready var doit_button: TextureButton = $ModalWindow/InfoContainer/ConfirmButtonContainer/DoitButton

func _ready() -> void:
    # Data bus format:
    # "<ticker>;<action>"
    # e.g. "JINH;BUY"

    super._ready()
    assert(len(GameState.switch_page_data_bus.split(';')) == 2)
    ticker = GameState.switch_page_data_bus.split(';')[0].to_upper()
    action = Mode[GameState.switch_page_data_bus.split(';')[1].to_upper()]
    
    _disable_value_calculation_field()
    _update_stock_info()
    GameState.delayed_tick.connect(_update_stock_info)

func _update_stock_info() -> void:
    stock = GameState.stock_market.get_stock(ticker)
    TickerLabel.text = "%s (%s)" % [stock.company_name, stock.ticker_symbol]
    ValueLabel.text = "%.2f" % stock.current_value
    UpDownLabel.text = (
        SharedConstants.UP_SYMBOL if stock.last_delta >= 0 
        else SharedConstants.DOWN_SYMBOL
    )
    UpDownLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if stock.last_delta >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
    
    NetChangeValueLabel.text = "%.2f" % stock.last_delta
    NetChangeValueLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if stock.last_delta >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
    NetChangePercentLabel.text = (
        "("
        + ("+" if stock.last_delta >= 0 else "")
        + "%.2f" % (100.0 * (stock.last_delta / (stock.last_delta + stock.current_value)))
        + "%)"
    )
    NetChangePercentLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if stock.last_delta >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
    BuyButton.disabled = action != Mode.BUY
    BuyButton.button_pressed = action == Mode.BUY
    SellButton.disabled = action != Mode.SELL
    SellButton.button_pressed = action == Mode.SELL

    _on_quantity_edit_text_changed(QuantityEdit.text)
    doit_button.disabled = !_validate_transaction()


func _disable_value_calculation_field() -> void:
    TransactionValueLabel.visible = false
    ForATotalValueOfLabel.visible = false

func _display_and_update_value_calculation_field(quantity: int) -> void:
    if !stock:
        stock = GameState.stock_market.get_stock(ticker)
    
    TransactionValueLabel.text = Helpers.currencyify(quantity * stock.current_value)
    TransactionValueLabel.visible = true
    ForATotalValueOfLabel.visible = true


func _validate_transaction() -> bool:
    var shares_owned: int = GameState.portfolio.how_many_shares(stock.ticker_symbol)
    var quantity: int = int(QuantityEdit.text)
    var value: float = stock.current_value

    if action == Mode.BUY and GameState.cash < (quantity * value):
        return false
    if action == Mode.SELL and shares_owned < quantity:
        return false
    return true

func _on_quantity_edit_text_changed(new_text: String) -> void:
    if !new_text.is_valid_int():
        _disable_value_calculation_field()
        return

    _display_and_update_value_calculation_field(
        new_text.to_int()
    )


func _on_doit_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_BUYSELL)

    if !_validate_transaction():
        return

    pass # Replace with function body.
