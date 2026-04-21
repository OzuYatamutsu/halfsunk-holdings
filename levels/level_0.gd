extends Day


func _ready() -> void:
    day = Day.DayOfWeek.MONDAY
    events = {
        Day.Phase.PREMARKET: _event_chat_message,
        Day.Phase.AFTERMARKET: _event_postmarket_chat_messages
    }

    super()
    start_next_phase()

func on_premarket_start() -> void:
    super()

    AudioEngine.play_bgm(AudioEngine.BGM_GAME)


func on_aftermarket_start() -> void:
    super()

    AudioEngine.pause_bgm()


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
