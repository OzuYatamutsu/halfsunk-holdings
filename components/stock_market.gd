class_name StockMarket
extends Node

## The StockMarket contains info on all Stock objects.

## {ticker: [name, value, description]}
const _MARKET_DATA: Dictionary[String, Array] = {
    "JINH": ["Jinhai Holdings", 100.00, "Financial", "Jinhai Holdings is a multinational trading firm headquartered in an unincorporated series of islands somewhere in the Pacific Ocean.\n\nIts core product, the Jinhaifund™, is a tax shelter marketed towards disgruntled information technology workers interested in changing careers to the agricultural industry."]
}

var _market: Dictionary[String, Stock] = {}

func _init() -> void:
    print("stock_market: initing (" + str(len(_MARKET_DATA)) + "stocks in market)")

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

func _on_tick() -> void:
    pass
