extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["Good morning!"]
    UserName = "Jinhai Qian"
    UserTitle = "President of Jinhai Holdings"
    UserProfilePath = "res://components/pfp_jinhai.png"
    ChatMessages = [
        "%TS/Hello, rookie.",
    ]
    YesAction = _1_continue
    
    super._ready()


func _1_continue() -> void:
    ButtonOptions = ["(...)"]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/We've given you $1,000 to trade stocks with.")
    await wait_secs(1)
    _2_on_wait()


func _2_on_wait() -> void:
    ButtonOptions = ["(...)"]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/Your goal is to double it by the end of next week.")
    await wait_secs(2)
    _3_on_wait()


func _3_on_wait() -> void:
    ButtonOptions = ["Oh..."]
    YesAction = _4_continue
    update_button_options()

    add_message("%TS/If you fail to do this you'll be fired, immediately.")


func _4_continue() -> void:
    pass  # TODO
