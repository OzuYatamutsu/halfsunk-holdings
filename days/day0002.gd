# week 0, day 2
extends Day


func _ready() -> void:
    day = Day.DayOfWeek.FRIDAY
    events = {
        Day.Phase.PREMARKET: _event_chat_message
    }

    super()
    start_next_phase()


func on_premarket_start() -> void:
    super()
    GameState.game_window.browser.load_page("res://pages/StartPage.tscn")


func on_aftermarket_start() -> void:
    super()


func on_close_end() -> void:
    super()
    
    GameState.end_of_week()


func _event_chat_message() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/day1_test_message1.gd"
    )
    GameState.game_window.add_child(chat_window)
