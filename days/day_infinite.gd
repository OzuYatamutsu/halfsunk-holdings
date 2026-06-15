class_name InfiniteDay
extends GeneralDay


## This type of day is a general day, but loops forever.
## (i.e. used in sandbox mode)


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
        day = DayOfWeek.MONDAY
    
    GameState.day_of_week = day

    super()


func on_close_end() -> void:
    super()

    GameState.load_day("res://days/day_infinite.gd")
