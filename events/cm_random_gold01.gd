extends ChatWindowModal

static var GoldEventPass = PriceChangeEvent.new(
    {"XMAU": 1.40}, "Gold miners rejoice after discovery of new gold site in some guy's backyard!"
)

static var GoldEventFail = PriceChangeEvent.new(
    {"CAT": 0.85}, "Feline Mega Capital shares tumble today after star trader digs around in his backyard and accidentally discovers oil, soiling his expensive suit"
)

var SelectedEvent: PriceChangeEvent


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["Huh?"]
    UserName = "Todd Grasley"
    UserTitle = "Fund Manager at Feline Mega Capital"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/im rich! rich!!!"
    ]
    YesAction = _0_on_yes_button_pressed

    if (randf() <= 0.2):
        SelectedEvent = GoldEventPass
    else:
        SelectedEvent = GoldEventFail

    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/i picked up a new metal detector at TOPSCALE this past weekend")
    await wait_secs(1)
    _1_on_wait()


func _1_on_wait() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/and i was digging around in my yard right")
    await wait_secs(1)
    _2_on_wait()


func _2_on_wait() -> void:
    ButtonOptions = ["Uh..."]
    YesAction = _3_on_yes_button_pressed
    update_button_options()

    add_message("%TS/beep! beep!! beep!!!")


func _3_on_yes_button_pressed() -> void:
    ButtonOptions = ["Maybe it's just trash?"]
    add_message("%TS/im rich!! smell ya later!")
    YesAction = _close_window
    update_button_options()


func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
