# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed

## A tick is a unit of time in the game clock.
## Examples of things which happen on each tick:
## Stock values change, messages may or may not
## be sent, etc.
signal tick

## Unit of time corresponding to one tick.
const TICK_LENGTH_SECS: float = 5.0

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
    game_timer = Timer.new()
    game_timer.wait_time = TICK_LENGTH_SECS
    game_timer.connect("timeout", _on_game_timer)

func _on_game_timer() -> void:
    tick.emit()
