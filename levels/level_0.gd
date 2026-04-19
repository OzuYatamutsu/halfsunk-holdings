extends Day


func _ready() -> void:
    day = Day.DayOfWeek.MONDAY
    events = {Day.Phase.PREMARKET: _event_chat_message}

    super()
    start_next_phase()

func on_premarket_start() -> void:
    super()

    AudioEngine.play_bgm(AudioEngine.BGM_GAME)


func on_marketopen_start() -> void:
    super()


func _event_chat_message() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/day0_test_message1.gd"
    )
    GameState.game_window.add_child(chat_window)
