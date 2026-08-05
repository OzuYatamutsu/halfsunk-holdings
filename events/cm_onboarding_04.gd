extends ChatWindowModal


static var OnboardingPCE02 = PriceChangeEvent.new(
    {"CAT": 1.10}, ""
)


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["Gross?"]
    UserName = "Jinhai Qian"
    UserTitle = "President of Jinhai Holdings"
    UserProfilePath = "res://components/pfp_jinhai.png"
    ChatMessages = [
        "%TS/Some retail investors bought the dip as well. Gross...",
    ]
    YesAction = _1_continue
    OnboardingPCE02.fire()
    GameState.force_refresh()
    super._ready()


func _1_continue() -> void:
    ButtonOptions = ["(close)"]
    YesAction = _close_window
    update_button_options()

    add_message("%TS/Gross?", true)
    add_message("%TS/Let’s SELL those shares back. (This can also be done by typing the command SELL CAT 10 in your command window.)")

func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
