# StockScreener
extends PageContent

## Loads ticker symbol from GameState.switch_page_data_bus
## (as a String).

@export var ticker_symbol: String
@export var stock: Stock

@onready var FullTickerLabel: Label = $DynamicPageContent/InfoboxContainer/Header/FullTickerLabel
@onready var TickerSymbolLabel: Label = $DynamicPageContent/InfoboxContainer/Header/TickerSymbolLabel
@onready var ValueLabel: Label = $DynamicPageContent/InfoboxContainer/ValueContainer/ValueLabel
@onready var UpDownLabel: Label = $DynamicPageContent/InfoboxContainer/ValueContainer/UpDownLabel

@onready var NetChangeValueLabel: Label = $DynamicPageContent/InfoboxContainer/ValueContainer/NetChangeValueLabel
@onready var NetChangePercentLabel: Label = $DynamicPageContent/InfoboxContainer/ValueContainer/NetChangePercentLabel
@onready var CompanyCategoryLabel: Label = $DynamicPageContent/InfoboxContainer/ValueContainer/CompanyCategoryLabel
@onready var CompanyDescriptionLabel: Label = $DynamicPageContent/InfoboxContainer/DescriptionContainer/CompanyDescriptionLabel
@onready var OwnedValueLabel: Label = %OwnedValueLabel
@onready var TotalValueLabel: Label = %TotalValueValueLabel
@onready var GainLossValueLabel: Label = %GainLossValueLabel

@onready var PriceChart: StockChart = $DynamicPageContent/Chartbox/ChartInfoArea/VBoxContainer/StockChart

func _ready():
    Title = "LOADING - Stock Screener"
    PageHeightY = 1200
    ticker_symbol = GameState.switch_page_data_bus

    update_scrollable_area()
    _populate_data()
    GameState.delayed_tick.connect(_populate_data)

func _populate_data() -> void:
    assert(ticker_symbol != "")
    print("stock_screener: refreshing data for " + ticker_symbol)
    stock = GameState.stock_market.get_stock(ticker_symbol)

    Title = ticker_symbol + " - Stock Screener"
    FullTickerLabel.text = stock.company_name
    TickerSymbolLabel.text = stock.ticker_symbol
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
    CompanyCategoryLabel.text = stock.company_category
    CompanyDescriptionLabel.text = stock.company_description
    OwnedValueLabel.text = "%s" % GameState.portfolio.how_many_shares(stock.ticker_symbol)
    TotalValueLabel.text = "%.2f" % GameState.portfolio.value_of_shares(stock.ticker_symbol)
    GainLossValueLabel.text = "%.2f" % GameState.portfolio.total_delta(stock.ticker_symbol)
    GainLossValueLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if float(GainLossValueLabel.text) >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
    GainLossValueLabel.text = (
        SharedConstants.UP_SYMBOL if float(GainLossValueLabel.text) >= 0
        else SharedConstants.DOWN_SYMBOL
    ) + " " + GainLossValueLabel.text

    PriceChart.add_point(stock.last_values[-1])

func _on_buy_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_CLICK)
    GameState.switch_page_data_bus = "%s;%s" % [ticker_symbol, "BUY"]
    var buy_sell_modal = load("res://components/BuySellModal.tscn").instantiate()
    get_tree().current_scene.add_child(buy_sell_modal)

func _on_sell_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_CLICK)
    GameState.switch_page_data_bus = "%s;%s" % [ticker_symbol, "SELL"]
    var buy_sell_modal = load("res://components/BuySellModal.tscn").instantiate()
    get_tree().current_scene.add_child(buy_sell_modal)
