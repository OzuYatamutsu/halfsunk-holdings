class_name Day
extends Node

## A Day is split into four phases, PreMarket, MarketOpen,
## AfterMarket, and Close. Events occur during each
## day during each phase, and time advances when conditions
## within each phase are met.


## Events are called at the start of each phase.
## Events are ordered. To have multiple events occur
## in a phase, pass in a callable which calls another
## callable at the end of execution.
var events: Dictionary[Phase, Callable] = {}


enum DayOfWeek {
    MONDAY = 0,
    TUESDAY = 1,
    WEDNESDAY = 2,
    THURSDAY = 3,
    FRIDAY = 4
}


enum Phase {
    PREMARKET = 0,
    MARKETOPEN = 1,
    AFTERMARKET = 2,
    CLOSE = 3
}


func on_premarket_start() -> void:
    if Phase.PREMARKET in events:
        events[Phase.PREMARKET].call()


func on_premarket_end() -> void:
    pass


func on_marketopen_start() -> void:
    if Phase.MARKETOPEN in events:
        events[Phase.MARKETOPEN].call()


func on_marketopen_end() -> void:
    pass


func on_aftermarket_start() -> void:
    if Phase.AFTERMARKET in events:
        events[Phase.MARKETOPEN].call()
    

func on_aftermarket_end() -> void:
    pass


func on_close_start() -> void:
    if Phase.CLOSE in events:
        events[Phase.CLOSE].call()


func on_close_end() -> void:
    pass
