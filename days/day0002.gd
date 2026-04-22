# week 0, day 2
extends Day


func _ready() -> void:
    day = Day.DayOfWeek.TUESDAY
    events = {}

    super()
    start_next_phase()


func on_premarket_start() -> void:
    super()


func on_aftermarket_start() -> void:
    super()


func on_close_end() -> void:
    super()
