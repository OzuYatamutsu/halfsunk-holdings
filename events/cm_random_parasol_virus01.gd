extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["What does it do?"]
    UserName = "Alex Bones"
    UserTitle = "Bioresearcher at Snake Biolabs"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/Our new drug is set to release later this year. It's called the Parasol Virus..."
    ]
    YesAction = _0_on_yes_button_pressed

    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["Oh..."]
    YesAction = _close_window
    update_button_options()

    add_message("%TS/It turns you into your fursona lmao")


func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
