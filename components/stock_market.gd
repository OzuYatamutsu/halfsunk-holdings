class_name StockMarket
extends Node

## The StockMarket contains info on all Stock objects.

## {ticker: [name, value, description]}
const _MARKET_DATA: Dictionary[String, Array] = {
    "JINH": ["Jinhai Holdings", 100.00, "Financial", "Jinhai Holdings is a multinational trading firm headquartered in an unincorporated series of islands somewhere in the Pacific Ocean.\n\nIts core product, the Jinhaifund™, is a tax shelter marketed towards disgruntled information technology workers interested in changing careers to the agricultural industry."]
}

## If not influenced by weight, how much should the stock randomly
## move on each tick?
const RANDOM_RANGE_PCTS = [-0.02, 0.02]

var _market: Dictionary[String, Stock] = {}

func _init() -> void:
    print("stock_market: initing (" + str(len(_MARKET_DATA)) + " stocks in market)")

    # TODO: load from previous data
    # TODO: for now just seed previous data

    for _ticker in _MARKET_DATA:
        print("stock_market: inserting " + _ticker)

        _market[_ticker] = Stock.new(
            _ticker,
            _MARKET_DATA[_ticker][0],
            _MARKET_DATA[_ticker][1],
            _MARKET_DATA[_ticker][2],
            _MARKET_DATA[_ticker][3]
        )
    
    GameState.tick.connect(_on_tick)

## Returns null if stock wasn't found
func get_stock(ticker: String) -> Stock:
    return _market.get(ticker, null)

## Insert or update
func update_stock(stock: Stock) -> void:
    _market.erase(stock.ticker_symbol)
    _market[stock.ticker_symbol] = stock

## Periodically shift values of all stocks in the market.
func market_random_shift() -> void:
    for stock: Stock in _market.values():
        var target_value = Helpers.money_round(
            stock.current_value * (
                1.0 + randf_range(RANDOM_RANGE_PCTS[0], RANDOM_RANGE_PCTS[1])
            )
        )
        var last_delta = target_value - stock.current_value
        
        print(
            "stock_market: [random_shift] %s -> %.2f (change %.2f)"
            % [stock.ticker_symbol, target_value, last_delta]
        )
        
        stock.last_values.append([
            stock.last_update_timestamp, stock.current_value
        ])
        if stock.last_values.size() > Stock.MAX_HISTORY_LENGTH:
            stock.last_values.pop_front()
        stock.current_value = target_value
        stock.last_delta = last_delta
        stock.last_update_timestamp = GameState.get_current_timestamp()
        update_stock(stock)

func _on_tick() -> void:
    market_random_shift()
