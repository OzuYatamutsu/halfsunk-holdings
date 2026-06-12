class_name InfiniteDay
extends GeneralDay


## This type of day is a general day, but loops forever.
## (i.e. used in sandbox mode)


func _ready() -> void:
    # Advance forwards by one day
    GameState.current_day.day = clamp(
        GameState.current_day.day + 1,
        DayOfWeek.MONDAY,
        DayOfWeek.FRIDAY
    )
    
    super()
