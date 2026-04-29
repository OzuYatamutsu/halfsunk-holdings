# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed


const BUILD_DATE: String = "20260423"
const VERSION_STRING: String = "0.4.2"

const STARTING_CASH: float = 1000.0
const STARTING_NET_WORTH: float = 1000.0
const STARTING_DAY: int = 1

var cash: float = 0.0
var portfolio: Portfolio = Portfolio.new()
var net_worth: float = 0.0
var total_score: float = 0.0
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


## e.g. day 1, action 5 = 5, day 2, action 2 = 10
func get_current_timestamp() -> int:
    if (current_day):
        return (day_count * Day.MARKETOPEN_ACTION_COUNT) + current_day.action_count
    else:
        return (day_count * Day.MARKETOPEN_ACTION_COUNT)


## "Monday, 12:00"
func get_current_timestamp_humanized() -> String:
    if (current_day):    
        return "%s, %s" % [Day.DayOfWeek.keys()[current_day.day], get_time()]
    else:
        return "Day %s, %s" % [day_count, get_time()]


## Call this to trigger an end of week state
func end_of_week() -> void:
    print("end of week calculation start")
    total_score += net_worth

    # Scene with end of week animations
    var _end_of_week_anim: PhaseTransitionAnim = load("res://components/EndOfWeekAnim.tscn").instantiate()
    current_day.add_child(_end_of_week_anim)
    await _end_of_week_anim.animation_complete
    
    print("net worth: %.2d, target: %.2d" % [net_worth, target])
    if (target < net_worth):
        print("entering eow losing state")
    else:
        print("entering eow winning state")
        
        # Clear out all investments in prep for next week
        cash = 0.0
        net_worth = 0.0
        target = 0.0
        portfolio.clear()
        
        # TODO: save stock prices to StockMarket
