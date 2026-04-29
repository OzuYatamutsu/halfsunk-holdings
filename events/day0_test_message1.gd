extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["OK!"]
    UserName = "Awre Twelve"
    UserTitle = "Hedge Fund Manager at Corvid Group"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/hi want some terrible investment advice"
    ]
    YesAction = _0_on_yes_button_pressed

    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()
    GameState.target = 1200.00

    add_message("%TS/don't pay us $1,200 by the end of the week")
    await wait_secs(1)
    _1_on_wait()
    

func _1_on_wait() -> void:
    add_message("%TS/and we take everything!! muhahaha!!")
    ButtonOptions = ["That's a lot of money!"]
    YesAction = _2_on_yes_button_pressed
    update_button_options()


func _2_on_yes_button_pressed() -> void:
    add_message("%TS/not my problem lmao")
    ButtonOptions = ["OK..."]
    YesAction = _3_on_yes_button_pressed
    update_button_options()


func _3_on_yes_button_pressed() -> void:
    IgnoreCloseRequests = false
    GameState.current_day.last_event_finished.emit()
    close()
