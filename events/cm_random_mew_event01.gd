extends ChatWindowModal


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["me? i guess?", "uh...not me!"]
    UserName = "mew cashin"
    UserTitle = "Lead Analyst at Chicken Little Capital"
    UserProfilePath = "res://components/pfp_mew.png"
    ChatMessages = [
        "%TS/who's buyin stocks when the riskfree rate is over 6%?!",
    ]
    YesAction = _0_on_yes_button_pressed
    NoAction = _0_on_no_button_pressed
    
    super._ready()


func _0_on_yes_button_pressed() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/...")
    await wait_secs(1)
    _1_on_wait()


func _0_on_no_button_pressed() -> void:
    ButtonOptions = ["..."]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/smart kid!!")
    await wait_secs(1)
    _2_on_wait()


func _1_on_wait() -> void:
    # TODO: increase volatility of entire market
    ButtonOptions = ["(close)"]
    YesAction = noop_action
    update_button_options()

    add_message("%TS/i hope it's only the OPTIONS that expire tomorrow...")
    AudioEngine.play_sfx(AudioEngine.SFX_UPDATE)
    GameState.game_window.marquee.queue_text(
        "Oh, no! Market volatility has sharply increased!"
    )
    YesAction = _close_window
    update_button_options()


func _2_on_wait() -> void:
    ButtonOptions = ["(close)"]
    add_message("%TS/brb, new cpi report just dropped")
    YesAction = _close_window
    update_button_options()


func _close_window() -> void:
    IgnoreCloseRequests = false
    close()
