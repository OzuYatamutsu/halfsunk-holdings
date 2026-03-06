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

func _ready():
    Title = "LOADING - Stock Screener"
    PageHeightY = 1400
    ticker_symbol = GameState.switch_page_data_bus

    update_scrollable_area()
    _populate_data()

func _populate_data() -> void:
    assert(ticker_symbol != "")
    print("stock_screener: looking up " + ticker_symbol)
    stock = GameState.stock_market.get_stock(ticker_symbol)

    Title = ticker_symbol + " - Stock Screener"
    FullTickerLabel.text = stock.company_name
    TickerSymbolLabel.text = stock.ticker_symbol
    ValueLabel.text = "%.2d" % stock.current_value
    UpDownLabel.text = (
        SharedConstants.UP_SYMBOL if stock.last_delta >= 0 
        else SharedConstants.DOWN_SYMBOL
    )
    UpDownLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if stock.last_delta >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
    
    NetChangeValueLabel.text = "%.2d" % stock.last_delta
    NetChangePercentLabel.text = "%.2d" % (100.0 * (stock.last_delta / (stock.last_delta + stock.current_value)))
    NetChangePercentLabel.add_theme_color_override("font_color", Color(
        SharedConstants.POSITIVE_COLOR_CODE if stock.last_delta >= 0
        else SharedConstants.NEGATIVE_COLOR_CODE
    ))
    CompanyCategoryLabel.text = stock.company_category
    CompanyDescriptionLabel.text = stock.company_description
