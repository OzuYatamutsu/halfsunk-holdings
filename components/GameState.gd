# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed

## A tick is a unit of time in the game clock.
## Examples of things which happen on each tick:
## Stock values change, messages may or may not
## be sent, etc.
signal tick

## This signal is fired a short time after the
## tick. Useful for things which consume data
## updated by tick (to prevent race condition)
## -- i.e., updating labels.
signal delayed_tick

## Unit of time corresponding to one tick.
const TICK_LENGTH_SECS: float = 5.0

## One tick represents how much time within
## the game world?
const TICK_IN_GAME_TIME_MINS: int = 5

## Unit of time to wait after one tick to fire
## the delayed_tick event.
const AFTER_TICK_DELAY_SECS: float = 0.05

const BUILD_DATE: String = "20260408"
const VERSION_STRING: String = "0.2.6"

const START_TIME_SECS: int = 30600
const STARTING_CASH: float = 1000.0
const STARTING_DEBT: float = 0.0
const STARTING_NET_WORTH: float = 1000.0
const STARTING_DAY: int = 1

var cash: float = 0.0
var portfolio: Portfolio = Portfolio.new()
var debt: float = 0.0
var net_worth: float = 0.0
var day_count: int = 1
var game_timer: Timer = Timer.new()
var delayed_tick_timer: Timer = Timer.new()
var tick_count: int = 0

var game_window: GameWindow
var stock_market: StockMarket

## Use this to pass data between pages.
var switch_page_data_bus: Variant

func _init() -> void:
    _tick_timer_setup()

func clear_state() -> void:
    if stock_market:
        stock_market.queue_free()
    stock_market = StockMarket.new()
    cash = STARTING_CASH
    portfolio.clear()
    debt = STARTING_DEBT
    net_worth = STARTING_NET_WORTH
    day_count = STARTING_DAY
    switch_page_data_bus = ""
    tick_count = 0

func start_day() -> void:
    tick_count = 0
    game_timer.start()
    
    cash_changed.emit()
    net_worth_changed.emit()
    game_window.hud_status.update()

func end_day() -> void:
    game_timer.stop()


func recalculate_net_worth() -> void:
    net_worth = cash + portfolio.value() - debt
    net_worth_changed.emit()


## A timestamp in the game is of the form: 30258
## => day 3, tick 0258. One tick represents TICK_LENGTH_SECS
## amount of real world time, and TICK_IN_GAME_TIME_MINS
## amount of fictional game time.
func get_current_timestamp() -> int:
    return Helpers.to_timestamp(day_count, tick_count)


## game timestamp of 10001 => "Day 1, 08:30:05"
func get_current_timestamp_humanized() -> String:
    var realworld_time_secs = (
        START_TIME_SECS 
        + (tick_count * TICK_IN_GAME_TIME_MINS * 60)
    )

    return "Day %s, %s" % [
        day_count,
        _realworld_time_secs_to_timestring(realworld_time_secs)
    ]


func _realworld_time_secs_to_timestring(realworld_time_secs: int) -> String:
    @warning_ignore("integer_division")
    return "%02d:%02d:%02d" % [
        realworld_time_secs / 3600,
        (realworld_time_secs % 3600) / 60,
        realworld_time_secs % 60
    ]


func _tick_timer_setup() -> void:
    game_timer.wait_time = TICK_LENGTH_SECS
    game_timer.timeout.connect(_on_game_timer)
    delayed_tick_timer.timeout.connect(_on_delayed_game_timer)
    delayed_tick_timer.wait_time = AFTER_TICK_DELAY_SECS
    delayed_tick_timer.one_shot = true
    add_child(game_timer)
    add_child(delayed_tick_timer)


func _on_game_timer() -> void:
    tick_count += 1
    tick.emit()
    delayed_tick_timer.start()


func _on_delayed_game_timer() -> void:
    recalculate_net_worth()
    delayed_tick.emit()
