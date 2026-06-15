class_name GeneralDay
extends Day


## This type of Day doesn't have any particular story
## events. It can be used within the story, or as a
## general day in sandbox mode.


func _ready() -> void:
    events = {}

    super()
    start_next_phase()


func on_premarket_start() -> void:
    super()
    AudioEngine.play_bgm(AudioEngine.BGM_GAME)
    GameState.game_window.browser.load_page("res://pages/StartPage.tscn")
    

func on_premarket_end() -> void:
    super()


func on_action_taken() -> void:
    # If we have random chat events to fire, do so if
    # we pass the random check.
    if (RandomEventsEmitter.hasUnfiredRandomEvents()):
        if (randf() <= random_chat_message_chance_pct):
            RandomEventsEmitter.returnRandomEvent().fire()

    # Otherwise, if we have random price movements to fire,
    # do so if we pass the random check.
    elif (PriceMovementsRandom.hasUnfiredRandomEvents()):
        if (randf() <= random_price_movement_chance_pct):
            PriceMovementsRandom.returnRandomEvent().fire()


func on_aftermarket_start() -> void:
    super()
    AudioEngine.pause_bgm()


func on_close_end() -> void:
    super()
