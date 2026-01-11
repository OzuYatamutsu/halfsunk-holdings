# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed

const STARTING_CASH: float = 0.0
const STARTING_DEBT: float = 0.0
const STARTING_NET_WORTH: float = 0.0
const STARTING_DAY: int = 1

var cash: float = 0.0
var investments: Portfolio = Portfolio.new()
var debt: float = 0.0
var net_worth: float = 0.0
var day_count: int = 1

func clear_state() -> void:
    cash = STARTING_CASH
    investments.clear()
    debt = STARTING_DEBT
    net_worth = STARTING_NET_WORTH
    day_count = STARTING_DAY

func recalculate_net_worth() -> void:
    net_worth = cash + investments.value() - debt
    net_worth_changed.emit()
