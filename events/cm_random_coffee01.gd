extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["OK!", "Maybe not..."]
    UserName = "Jordan Belmont"
    UserTitle = "Bioresearcher at Jinhai Holdings"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/Let's meet for coffee at EXPENSIVE RESTAURANT."
    ]
    YesAction = _0_on_yes_button_pressed
    NoAction = _close_window

    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["(close)"]
    YesAction = _close_window
    update_button_options()

    GameState.cash -= 100
    if GameState.cash < 0:
        GameState.cash = 0
    GameState.cash_changed.emit()
    GameState.recalculate_net_worth()

    add_message("%TS/[Expensed EXPENSIVE COFFEE (-$100.)]")


func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
