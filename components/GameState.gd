# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed

const STARTING_CASH: float = 0.0
const STARTING_NET_WORTH: float = 0
const STARTING_DAY: int = 1

var Cash: float = 0.0
var NetWorth: float = 0.0
var DayCount: int = 1

func clear_state() -> void:
    Cash = STARTING_CASH
    NetWorth = STARTING_NET_WORTH
    DayCount = STARTING_DAY

func recalculate_net_worth() -> void:
    NetWorth = Cash  # TODO

    net_worth_changed.emit()
