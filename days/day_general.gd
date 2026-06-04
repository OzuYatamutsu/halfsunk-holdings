# general day
extends Day


## This type of Day doesn't have any particular story
## events. It can be used within the story, or as a
## general day in sandbox mode.


func _ready() -> void:
    if (GameState.current_day.day == Day.DayOfWeek.MONDAY):
        # First day of week
        GameState.clear_state()

    events = {
        Day.Phase.PREMARKET: null,
        Day.Phase.MARKETOPEN: null,
        Day.Phase.AFTERMARKET: null,
        Day.Phase.CLOSE: null
    }

    super()
    start_next_phase()


func on_action_taken() -> void:
    pass  # TODO


func on_premarket_start() -> void:
    super()
    pass  # TODO


func on_premarket_end() -> void:
    super()
    pass  # TODO


func on_aftermarket_start() -> void:
    super()
    AudioEngine.pause_bgm()
    pass  # TODO


func on_close_end() -> void:
    super()
    pass  # TODO
