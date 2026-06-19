class_name InfiniteDay
extends GeneralDay


## This type of day is a general day, but loops forever.
## (i.e. used in sandbox mode)


## How much should the weekly goal increase
## at the start of the week?
const GOAL_INCREASE_MULTIPLIER: float = 1.30


func _ready() -> void:
    # Advance forwards by one day
    day = clamp(
        GameState.day_of_week + 1,
        DayOfWeek.MONDAY,
        DayOfWeek.FRIDAY
    )
    
    # If we're at the end of the week,
    # loop back around to Monday
    if day == GameState.day_of_week:
        var new_target = float("%.2f" % [GameState._old_target * GOAL_INCREASE_MULTIPLIER])
        print("increasing goal from %s to %s" % [GameState._old_target, new_target])
        GameState.target = new_target
        day = DayOfWeek.MONDAY

    GameState.day_of_week = day

    super()


func on_close_end() -> void:
    super()

    if GameState.day_of_week != DayOfWeek.FRIDAY:
        GameState.load_day("res://days/day_infinite.gd")
    else:
        GameState.end_of_week_calc_done.connect(_on_end_of_week_complete)
    

func _on_end_of_week_complete():
    GameState.end_of_week_calc_done.disconnect(_on_end_of_week_complete)
    GameState.load_day("res://days/day_infinite.gd")
