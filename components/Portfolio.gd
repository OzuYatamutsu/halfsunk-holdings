class_name Portfolio
extends Node

## A collection of stocks, etc. (not cash)

var _portfolio: Dictionary[String, int] = {}
var _lots: Dictionary[String, Array] = {}

func buy(stock: String, quantity: int) -> void:
    if stock not in _portfolio:
        _portfolio[stock] = 0
        _lots[stock] = []
    _portfolio[stock] += quantity
    _lots[stock].append(
        GameState.stock_market.get_stock(stock).current_value * quantity
    )

func sell(stock: String) -> void:
    assert(stock in _portfolio, "tried to sell a stock not in the portfolio!")
    
    _portfolio[stock] -= 1
    if _portfolio[stock] <= 0:
        _portfolio.erase(stock)
        _lots.erase(stock)

func clear() -> void:
    _portfolio.clear()

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
    for _basis in _lots[stock]:
        total_basis += _basis
    return (
        GameState.stock_market.get_stock(stock).current_value
        * _portfolio[stock]
    ) - total_basis

func value() -> float:
    var _value = 0.0

    for _stock in _portfolio:
        _value += (
            _portfolio[_stock]
            * GameState.stock_market.get_stock(_stock).current_value
        )
    return _value
