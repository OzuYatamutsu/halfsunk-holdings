# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed

const VERSION_STRING: String = "0.0.1"
const STARTING_CASH: float = 0.0
const STARTING_DEBT: float = 0.0
const STARTING_NET_WORTH: float = 0.0
const STARTING_DAY: int = 1

var BUILD_DATE: String = "20260222"
var cash: float = 0.0
var investments: Portfolio = Portfolio.new()
var debt: float = 0.0
var net_worth: float = 0.0
var day_count: int = 1

func _init() -> void:
    # _populate_build_date()
    pass

func _populate_build_date() -> void:
    var date = Time.get_date_dict_from_system()
    BUILD_DATE = "%04d%02d%02d" % [date.year, date.month, date.day]

func clear_state() -> void:
    cash = STARTING_CASH
    investments.clear()
    debt = STARTING_DEBT
    net_worth = STARTING_NET_WORTH
    day_count = STARTING_DAY

func recalculate_net_worth() -> void:
    net_worth = cash + investments.value() - debt
    net_worth_changed.emit()
