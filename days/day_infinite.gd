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
    GameState.day_of_week = day

    super()
