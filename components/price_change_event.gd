class_name PriceChangeEvent
extends Node

## A PriceChangeEvent results in a deterministic movement
## of a specific ticker's price.

var ticker: String

## Normalized at 1.00. e.g., a 5% increase is 1.05, a
## 5% decrease is 0.95.
var changePercent: float

## Displayed in the marquee on the bottom of the screen.
var description: String


func _init(
    _ticker: String, _changePercent: float,
    _description: String
) -> void:
    ticker = _ticker
    changePercent = _changePercent
    description = _description


## Executes the event. Effects take effect immediately.
func fire() -> void:
    var stock: Stock = GameState.stock_market.get_stock(ticker)
    var targetValue: float = Helpers.money_round(
        stock.current_value * changePercent
    )
    var delta: float = targetValue - stock.current_value
    print(
        "event: [price_change_event] %s -> %.2f (change %.2f)"
        % [ticker, targetValue, delta]
    )
    
    stock.last_values.append([
        stock.last_update_timestamp, stock.current_value
    ])
    if stock.last_values.size() > Stock.MAX_HISTORY_LENGTH:
        stock.last_values.pop_front()
    stock.current_value = targetValue
    stock.last_delta = delta
    stock.last_update_timestamp = GameState.get_current_timestamp()

    GameState.stock_market.update_stock(stock)
    GameState.game_window.marquee.queue_text(description)
