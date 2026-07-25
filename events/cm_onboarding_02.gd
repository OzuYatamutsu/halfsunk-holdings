extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["Like us?"]
    UserName = "Jinhai Qian"
    UserTitle = "President of Jinhai Holdings"
    UserProfilePath = "res://components/pfp_jinhai.png"
    ChatMessages = [
        "%TS/Aw, man, these guys have been a real pain in my ass...",
        "%TS/All day they just drink lots of coffee and make terrible investments."
    ]
    YesAction = _1_continue
    
    super._ready()


func _1_continue() -> void:
    ButtonOptions = ["(close)"]
    YesAction = _close_window
    update_button_options()

    add_message("%TS/Absolutely not.")

func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
