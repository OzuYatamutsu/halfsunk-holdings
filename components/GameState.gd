# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed


const BUILD_DATE: String = "20260414"
const VERSION_STRING: String = "0.4.1"

const STARTING_CASH: float = 1000.0
const STARTING_NET_WORTH: float = 1000.0
const STARTING_DAY: int = 1

var cash: float = 0.0
var portfolio: Portfolio = Portfolio.new()
var net_worth: float = 0.0
var target: float = 0.0
var current_day: Day
var day_count: int = 1

var game_window: GameWindow
var stock_market: StockMarket

## Use this to pass data between pages.
var switch_page_data_bus: Variant


func _init() -> void:
    pass


func clear_state() -> void:
    if stock_market:
        stock_market.queue_free()
    stock_market = StockMarket.new()
    cash = STARTING_CASH
    portfolio.clear()
    net_worth = STARTING_NET_WORTH
    day_count = STARTING_DAY
    target = 0.0
    switch_page_data_bus = ""


func start_day() -> void:
    switch_page_data_bus = ""
    current_day.action_taken.connect(
        stock_market.on_action_taken
    )

    cash_changed.emit()
    net_worth_changed.emit()
    game_window.hud_status.update()


func end_day() -> void:
    pass


func recalculate_net_worth() -> void:
    net_worth = cash + portfolio.value()
    net_worth_changed.emit()


func get_time() -> String:
    if (!current_day):
        return "08:00"
    if (current_day.phase == Day.Phase.PREMARKET):
        return "08:30"
    elif (current_day.phase == Day.Phase.MARKETOPEN):
        return "%s:00" % [str(
            Day.MARKETOPEN_START_HOUR + current_day.action_count
        ).pad_zeros(2)]
    elif (current_day.phase == Day.Phase.AFTERMARKET):
        return "17:00"
    else:  # Day.Phase.CLOSE
        return "18:00"


## 112
func get_current_timestamp() -> int:
    if (current_day):
        return (day_count * 100) + current_day.action_count
    else:
        return (day_count * 100)


## "Monday, 12:00"
func get_current_timestamp_humanized() -> String:
    if (current_day):    
        return "%s, %s" % [Day.DayOfWeek.keys()[current_day.day], get_time()]
    else:
        return "Day %s, %s" % [day_count, get_time()]
