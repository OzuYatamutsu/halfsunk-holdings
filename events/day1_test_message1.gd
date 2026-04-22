extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["Yeah!"]
    UserName = "Awre Twelve"
    UserTitle = "Hedge Fund Manager at Corvid Group"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/hi it's day 2"
    ]
    YesAction = _0_on_yes_button_pressed

    super._ready()


func _0_on_yes_button_pressed() -> void:
    # TODO implement
    IgnoreCloseRequests = false
    GameState.current_day.last_event_finished.emit()
    close()
