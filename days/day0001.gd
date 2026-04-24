# week 0, day 1
extends Day


func _ready() -> void:
    # First day of week
    GameState.clear_state()

    day = Day.DayOfWeek.THURSDAY
    events = {
        Day.Phase.PREMARKET: _event_chat_message,
        Day.Phase.AFTERMARKET: _event_postmarket_chat_messages
    }

    super()
    start_next_phase()

func on_premarket_start() -> void:
    super()

    GameState.game_window.browser.load_page("res://pages/StartPage.tscn")
    AudioEngine.play_bgm(AudioEngine.BGM_GAME)


func on_premarket_end() -> void:
    super()

    GameState.game_window.browser.load_page("res://pages/StartPage.tscn")


func on_aftermarket_start() -> void:
    super()

    AudioEngine.pause_bgm()

func on_close_end() -> void:
    super()

    get_tree().change_scene_to_file("res://days/day0002.tscn")


func _event_chat_message() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/day0_test_message1.gd"
    )
    GameState.game_window.add_child(chat_window)


func _event_postmarket_chat_messages() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/day0_test_message2.gd"
    )
    GameState.game_window.add_child(chat_window)
