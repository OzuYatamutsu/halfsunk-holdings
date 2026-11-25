# week 0, day 2
extends Day


func _ready() -> void:
    day = Day.DayOfWeek.TUESDAY
    events = {
        Day.Phase.PREMARKET: _event_chat_message
    }

    super()
    start_next_phase()
    GameState.game_window.marquee.start()


func on_premarket_start() -> void:
    super()
    AudioEngine.play_bgm(AudioEngine.BGM.BGM1)
    GameState.game_window.browser.load_page("res://pages/StartPage.tscn")


func on_aftermarket_start() -> void:
    super()


func on_close_end() -> void:
    super()
    
    GameState.load_day("res://days/day_infinite.gd")
    # GameState.end_of_week()


func _event_chat_message() -> void:
    ChatEventParser.load_chatevent_from_file(
        "res://events/cm_day2_intro01.txt"
    ).fire()
