class_name PriceChangeEvent
extends Node

## A PriceChangeEvent results in a deterministic movement
## of a specific ticker (or tickers)' price.

## Maps a ticker symbol to the change in price. e.g.
## {"JINH": 1.05, "CAT": "1.05", "DOG": 0.95}. 
## Normalized at 1.00. e.g., a 5% increase is 1.05,
## a 5% decrease is 0.95.
var tickerToChangePercent: Dictionary[String, float]

## Displayed in the marquee on the bottom of the screen.
var description: String


func _init(
    _tickerToChangePercent: Dictionary[String, float],
    _description: String
) -> void:
    tickerToChangePercent = _tickerToChangePercent
    description = _description


## Executes the event. Effects take effect immediately.
func fire() -> void:
    for ticker in tickerToChangePercent:
        var stock: Stock = GameState.stock_market.get_stock(ticker)
        var changePercent: float = tickerToChangePercent[ticker]
        var targetValue: float = Helpers.money_round(
            stock.current_value * changePercent
        )
        stock.update_price(targetValue)
        GameState.stock_market.update_stock(stock)

    GameState.game_window.marquee.queue_text(description)
    GameState.game_window.marquee.queue_text_from_stock_market_data()
