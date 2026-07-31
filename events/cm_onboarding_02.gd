extends ChatWindowModal

static var OnboardingPCE01 = PriceChangeEvent.new(
    {"CAT": 0.90}, "Civet Coffees press charges against CAT for ‘culture of unlicensed coffee consumption’. CAT shares tumble!"
)

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
    OnboardingPCE01.event_fired.connect(GameState.current_day._delay_event_onboarding03)
    
    super._ready()


func _1_continue() -> void:
    ButtonOptions = ["(close)"]
    YesAction = _close_window_and_fire_events
    update_button_options()

    add_message("%TS/Like us?", true)
    add_message("%TS/Absolutely not.")

func _close_window_and_fire_events() -> void:
    IgnoreCloseRequests = false
    OnboardingPCE01.fire()
    GameState.force_refresh()
    close()
