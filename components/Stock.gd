class_name Stock
extends Node

## A Stock represents a financial instrument with a set value that
## can increase or decrease over time.

@export var ticker_symbol: String = "NEW"
@export var company_name: String = "New Holdings Co., Ltd."
@export var company_description: String = "Company description here"
@export var company_category: String = "Energy"
@export var current_value: float = 0.0
@export var last_delta: float = 0.0

func _init(_ticker: String, _name: String, _base_value: float, _category: String, _description: String) -> void:
    ticker_symbol = _ticker
    company_name = _name
    current_value = _base_value
    company_category = _category
    company_description = _description
