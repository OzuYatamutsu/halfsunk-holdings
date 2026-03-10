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

## Unit of time to wait after one tick to fire
## the delayed_tick event.
const AFTER_TICK_DELAY_SECS: float = 0.05

const VERSION_STRING: String = "0.1.6"
const STARTING_CASH: float = 0.0
const STARTING_DEBT: float = 0.0
const STARTING_NET_WORTH: float = 0.0
const STARTING_DAY: int = 1

var BUILD_DATE: String = "20260306"
var cash: float = 0.0
var investments: Portfolio = Portfolio.new()
var debt: float = 0.0
var net_worth: float = 0.0
var day_count: int = 1
var game_timer: Timer = Timer.new()
var delayed_tick_timer: Timer = Timer.new()

var game_window: GameWindow
var stock_market: StockMarket

## Use this to pass data between pages.
var switch_page_data_bus: Variant

func _init() -> void:
    stock_market = StockMarket.new()
    _tick_timer_setup()

func clear_state() -> void:
    _tick_timer_setup()
    cash = STARTING_CASH
    investments.clear()
    debt = STARTING_DEBT
    net_worth = STARTING_NET_WORTH
    day_count = STARTING_DAY
    switch_page_data_bus = ""

func start_day() -> void:
    game_timer.start()

func end_day() -> void:
    game_timer.stop()

func recalculate_net_worth() -> void:
    net_worth = cash + investments.value() - debt
    net_worth_changed.emit()

func _tick_timer_setup() -> void:
    game_timer.wait_time = TICK_LENGTH_SECS
    game_timer.connect("timeout", _on_game_timer)
    delayed_tick_timer.wait_time = AFTER_TICK_DELAY_SECS
    delayed_tick_timer.one_shot = true

func _on_game_timer() -> void:
    tick.emit()
    delayed_tick_timer.start()

func _on_delayed_game_timer() -> void:
    delayed_tick.emit()
