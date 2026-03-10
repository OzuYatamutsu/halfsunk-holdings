class_name BuySellModal
extends Modal

enum Mode {
    BUY,
    SELL
}

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
@onready var QuantityEdit: TextEdit = $ModalWindow/InfoContainer/QuantitySelector/QuantityEdit
@onready var TickerEdit: TextEdit = $ModalWindow/InfoContainer/QuantitySelector/TickerEdit

# "$12,345.00"
@onready var TransactionValueLabel: Label = $ModalWindow/InfoContainer/TotalInfo/TransactionValueLabel

func _ready() -> void:
    # Data bus format:
    # "<ticker>;<action>"
    # e.g. "JINH;BUY"
    
    ticker = GameState.switch_page_data_bus.split(';').to_upper()[0]
    action = Mode[GameState.switch_page_data_bus.split(';').to_upper()[1]]
    _update_stock_info()

func _update_stock_info() -> void:
    var stock = GameState.stock_market.get_stock(ticker)
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
    NetChangePercentLabel.text = (
        "("
        + ("+" if stock.last_delta >= 0 else "-")
        + "%.2f)" % (100.0 * (stock.last_delta / (stock.last_delta + stock.current_value)))
    )
    NetChangePercentLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if stock.last_delta >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
