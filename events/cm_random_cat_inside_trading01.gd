extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["Uh...okay?"]
    UserName = "TODO TODO"
    UserTitle = "Hungry Trader at Jinhai Holdings"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/hey! *crunch crunch* got some news for you on a FAT trade"
    ]
    YesAction = _0_on_yes_button_pressed

    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/we got a BIG money move goin on!! let's buy up all the cat stocks!!")
    await wait_secs(1)
    _1_on_wait()
    

func _1_on_wait() -> void:
    add_message("%TS/are you in??")
    ButtonOptions = ["Yeah!", "Uh...yeah..."]
    YesAction = _2_on_yes_button_pressed
    update_button_options()


func _2_on_yes_button_pressed() -> void:
    add_message("%TS/i hate dogs!! *crunch crunch*")
    ButtonOptions = ["(close)"]
    YesAction = _3_on_yes_button_pressed
    update_button_options()


func _3_on_yes_button_pressed() -> void:
    IgnoreCloseRequests = false
    GameState.current_day.last_event_finished.emit()
    close()
