extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["About time for what?"]
    UserName = "Jinhai Qian"
    UserTitle = "President of Jinhai Holdings"
    UserProfilePath = "res://components/pfp_jinhai.png"
    ChatMessages = [
        "%TS/Hahahahah! It’s about time!!",
    ]
    YesAction = _1_continue
    
    super._ready()


func _1_continue() -> void:
    ButtonOptions = ["(close)"]
    YesAction = _close_window
    update_button_options()

    add_message("%TS/Time to BUY, of course. Buy 10 shares of CAT.")

func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
