extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["(close)"]
    UserName = "Jinhai Qian"
    UserTitle = "President of Jinhai Holdings"
    UserProfilePath = "res://components/pfp_jinhai.png"
    ChatMessages = [
        "%TS/Easy 10% profit, in just a few minutes...",
        "%TS/Just keep doing that! And make us LOTS OF MONEY!",
        "%T
        S/Or else...",
    ]
    YesAction = _close_window_and_fire_events

    super._ready()


func _close_window_and_fire_events() -> void:
    GameState.is_onboarding = false
    GameState.current_day.start_next_phase()
    IgnoreCloseRequests = false
    close()
