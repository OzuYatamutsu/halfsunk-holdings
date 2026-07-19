extends ChatWindowModal

static var OptionsEventPass = PriceChangeEvent.new(
    {"CAT": 2.00}, "Star trader from Feline Mega Capital discovers options trading and becomes fabulously rich!!"
)

static var OptionsEventFail = PriceChangeEvent.new(
    {"CAT": 0.50}, "Feline Mega Capital shares collapse after trader discovers options trading, proceeds to lose half of the company's money"
)
var SelectedEvent: PriceChangeEvent


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["What is it this time?"]
    UserName = "Chao Main"
    UserTitle = "Fund Manager at Feline Mega Capital"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%TS/HOO YEAH! I'm gonna make a BUNCH OF MONEY!"
    ]
    YesAction = _0_on_yes_button_pressed

    if (randf() <= 0.1):
        SelectedEvent = OptionsEventPass
    else:
        SelectedEvent = OptionsEventFail

    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/Guess who got approved for OPTIONS TRADING???")
    await wait_secs(1)
    _1_on_wait()


func _1_on_wait() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/I'm gonna double our funds money by TOMORROW!")
    await wait_secs(1)
    _2_on_wait()


func _2_on_wait() -> void:
    ButtonOptions = ["Trading derivatives involves high risk."]
    YesAction = _3_on_yes_button_pressed
    update_button_options()

    add_message("%TS/FOR SURE!")


func _3_on_yes_button_pressed() -> void:
    ButtonOptions = ["(close)"]
    add_message("%TS/Wait until I tell you about my new PERSCRIPTIONS!!!")
    YesAction = _close_window
    update_button_options()


func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
