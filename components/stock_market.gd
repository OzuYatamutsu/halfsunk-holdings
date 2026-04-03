class_name StockMarket
extends Node

## The StockMarket contains info on all Stock objects.

## {ticker: [name, value, category, description]}
const _MARKET_DATA: Dictionary[String, Array] = {
    "JINH": ["Jinhai Holdings", 100.00, "Financial", "Jinhai Holdings is a multinational trading firm headquartered in an unincorporated series of islands somewhere in the Pacific Ocean.\n\nIts core product, the Jinhaifund™, is a tax shelter marketed towards disgruntled information technology workers interested in changing careers to the agricultural industry."],
    "CAT": ["Feline Mega Capital", 51.00, "Financial", "Feline Mega Capital is a publicly owned investment manager, primarily providing services to rich institutional investors.\n\nIt spends 5% of its annual budget on cigars, caviar, and lasagna."],
    "DOG": ["Canine Energy", 26.00, "Energy", "Canine engages in the exploration and exploitation of crude oil, natural gas, and aromatics.\n\nStandard equipment for its prospectors include big boots and a giant hat."],
    "BIRD": ["Avian Express", 88.00, "Logistics", "Avian Express provides transportation, shipping, and business services through its network of 20,000 logistics centers.\n\nAvailable shipping options (in order of descending cost) include Bulky, Turbo, Standard, and \"Whatever's Cheapest\"."],
    "LZRD": ["TopScale Home Goods", 14.00, "Retail", "TopScale operates as a home improvement retailer, selling building materials, home improvement products, and roof shingles.\n\nIt previously offered general contracting services, but this was swiftly discontinued following the Great Swampening of 2007."],
    "TIGR": ["Tiger Electronics", 67.00, "Consumer Goods", "Tiger Electronics is the world's leading provider of rice cookers that sing to you.\n\nThat's all they make."]
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

func get_all_to_string() -> Array[String]:
    return _market.values().map(func(_stock): return _stock._to_string())

func _on_tick() -> void:
    market_random_shift()
