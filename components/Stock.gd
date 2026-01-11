class_name Stock
extends Node

signal value_changed
signal was_bought
signal was_sold

## If not influenced by weight, how much should the stock randomly
## move on each tick?
const RANDOM_RANGE_PCTS = [-0.02, 0.02]

## A Stock represents a financial instrument with a set value that
## can increase or decrease over time.

@export var TickerSymbol: String = "NEW"
@export var CompanyName: String = "New Holdings Co., Ltd."
@export var CurrentValue: float = 0 

func recalculate_value_on_tick(weight: float = 0, force_positive: bool = false,
                               force_negative: bool = false) -> void:
    var effective_range = RANDOM_RANGE_PCTS
    
    effective_range = [
        effective_range[0] + weight if not force_positive else 0.0,
        effective_range[1] + weight if not force_negative else 0.0
    ]
    
    CurrentValue = Helpers.money_round(
        CurrentValue * (
            1.0 + randf_range(effective_range[0], effective_range[1])
        )
    )
