extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["(close)"]
    UserName = "Jinhai Qian"
    UserTitle = "President of Jinhai Holdings"
    UserProfilePath = "res://components/pfp_jinhai.png"
    ChatMessages = [
        "%TS/That's all. Make sure to make lots of money this week!",
        "%TS/Or else...",
    ]
    YesAction = _close_window_and_fire_events

    super._ready()


func _close_window_and_fire_events() -> void:
    GameState.current_day.start_next_phase()
    IgnoreCloseRequests = false
    close()
