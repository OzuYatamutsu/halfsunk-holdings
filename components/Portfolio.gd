class_name Portfolio
extends Node

## A collection of stocks, etc. (not cash)

var _portfolio: Dictionary[String, int] = {}

## maps ticker symbol to array of [quantity, total value] arrays for each lot.
## example format: {"JINH": [[10, 100.0], 
var _lots: Dictionary[String, Array] = {}

func buy(stock: String, quantity: int) -> void:
    if stock not in _portfolio:
        _portfolio[stock] = 0
        _lots[stock] = []
    _portfolio[stock] += quantity
    _lots[stock].append([
        quantity,
        GameState.stock_market.get_stock(stock).current_value * quantity
    ])

func sell(stock: String, quantity: int) -> void:
    assert(stock in _portfolio, "tried to sell a stock not in the portfolio!")
    assert(_portfolio[stock] >= quantity)

    _portfolio[stock] -= quantity

    # update lots via FIFO
    var quantity_to_process = quantity
    while quantity_to_process > 0:
        var _current_lot = _lots[stock].pop_front()
        quantity_to_process -= _current_lot[0]
        
        if quantity_to_process < 0:
            _current_lot[1] = (
                (_current_lot[1] / _current_lot[0])
                * abs(quantity_to_process)
            )
            _current_lot[0] = abs(quantity_to_process)
            _lots[stock].push_front(_current_lot)
            quantity_to_process = 0
            break
        elif quantity_to_process >= 0:
            continue

    if _portfolio[stock] <= 0:
        _portfolio.erase(stock)
        _lots.erase(stock)

func clear() -> void:
    _portfolio.clear()
    _lots.clear()

func how_many_shares(stock: String) -> int:
    if stock not in _portfolio:
        return 0
    return _portfolio[stock]

func value_of_shares(stock: String) -> float:
    return (
        GameState.stock_market.get_stock(stock).current_value
        * how_many_shares(stock)
    )

func total_delta(stock: String) -> float:
    var total_basis: float = 0.0
    if stock not in _portfolio:
        return 0.0
    if stock not in _lots:
        return 0.0
    for _lot in _lots[stock]:
        total_basis += _lot[1]  # (basis)
    return (
        GameState.stock_market.get_stock(stock).current_value
        * _portfolio[stock]
    ) - total_basis

func total_delta_percent(stock: String) -> float:
    var _total_basis: float = 0.0
    var _total_delta = total_delta(stock)

    if _total_delta == 0:
        return 0.0
    for _lot in _lots[stock]:
        _total_basis += _lot[1]  # (basis)
    if _total_basis == 0.0:
        return 100.0

    return (_total_delta / _total_basis) * 100

func value() -> float:
    var _value = 0.0

    for _stock in _portfolio:
        _value += (
            _portfolio[_stock]
            * GameState.stock_market.get_stock(_stock).current_value
        )
    return _value
