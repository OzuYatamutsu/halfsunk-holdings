class_name Portfolio
extends Node

## A collection of stocks, etc. (not cash)

var _portfolio: Dictionary[Stock, int] = {}

func buy(stock: Stock) -> void:
    if stock not in _portfolio:
        _portfolio[stock] = 0
    _portfolio[stock] += 1

func sell(stock: Stock) -> void:
    assert(stock in _portfolio, "tried to sell a stock not in the portfolio!")
    
    _portfolio[stock] -= 1
    if _portfolio[stock] <= 0:
        _portfolio.erase(stock)

func clear() -> void:
    _portfolio.clear()

func how_many_shares(stock: Stock) -> int:
    if stock not in _portfolio:
        return 0
    return _portfolio[stock]

func value() -> float:
    var _value = 0.0

    for _stock in _portfolio:
        _value += (_portfolio[_stock] * _stock.CurrentValue)
    return _value
