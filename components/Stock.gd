class_name Stock
extends Node

## A Stock represents a financial instrument with a set value that
## can increase or decrease over time.

## What's the max length of last_values?
const MAX_HISTORY_LENGTH: int = 500

@export var ticker_symbol: String = "NEW"
@export var company_name: String = "New Holdings Co., Ltd."
@export var company_description: String = "Company description here"
@export var company_category: String = "Energy"
@export var current_value: float = 0.0
@export var last_delta: float = 0.0
@export var last_update_timestamp: int = 0

## each item is a tuple of: [timestamp, value.]
## see GameState for an explanation on how timestamp is calculated
## actual type is Array[Array] but can't properly annotate due to
## deserialization typing issues
@export var last_values: Array = []

func _init(_ticker: String, _name: String, _base_value: float, _category: String, _description: String, _last_values: Array = []) -> void:
    ticker_symbol = _ticker
    company_name = _name
    current_value = _base_value
    company_category = _category
    company_description = _description
    last_values = _last_values
    last_update_timestamp = GameState.get_current_timestamp()

    if last_values.size() <= 2:
        last_values = [
            [GameState.get_current_timestamp() - 1, current_value],
            [GameState.get_current_timestamp(), current_value],
        ]

func _to_string() -> String:
    return "%s %s %s %s (%s%s" % [
        ticker_symbol,
        Helpers.currencyify(current_value, false, true),
        SharedConstants.UP_SYMBOL if last_delta >= 0 else SharedConstants.DOWN_SYMBOL,
        Helpers.currencyify(abs(last_delta), true, true),
        "+" if last_delta >= 0 else "",
        Helpers.currencyify(abs(last_delta / current_value - last_delta), true, true)
    ] + '%)'


func serialize() -> String:
    return JSON.stringify({
        "ticker_symbol": ticker_symbol,
        "company_name": company_name,
        "company_description": company_description,
        "company_category": company_category,
        "current_value": current_value,
        "last_delta": last_delta,
        "last_update_timestamp": last_update_timestamp,
        "last_values": JSON.stringify(last_values)
    })


static func deserialize(json: String) -> Stock:
    var _data_obj = JSON.parse_string(json)
    var _stock: Stock = Stock.new(
        _data_obj["ticker_symbol"],
        _data_obj["company_name"],
        _data_obj["current_value"],
        _data_obj["company_category"],
        _data_obj["company_description"],
        JSON.parse_string(_data_obj["last_values"])
    )
    _stock.last_delta = _data_obj["last_delta"]
    _stock.last_update_timestamp = _data_obj["last_update_timestamp"]
    return _stock
