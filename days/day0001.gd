# week 0, day 1
extends Day

static var OnboardingPCE02 = PriceChangeEvent.new(
    {"CAT": 1.10}, ""
)


func _ready() -> void:
    # First day of week
    GameState.clear_state()

    day = Day.DayOfWeek.MONDAY
    events = {
        Day.Phase.PREMARKET: _event_onboarding,
        Day.Phase.AFTERMARKET: _event_postmarket_chat_messages
    }

    # Treats some behaviour differently
    GameState.is_onboarding = true

    GameState.game_window.command_prompt.command_fired.connect(
        _on_command_fired
    )
    super()
    start_next_phase()


func on_action_taken() -> void:
    if action_count == 1:
        _delay_event_onboarding04()
    if action_count == 2:
        _event_onboarding05()


func _on_command_fired(command: String) -> void:
    # hack
    if command == "INFO" and GameState.switch_page_data_bus == "CAT" and action_count == 0:
        _delay_event_onboarding02()


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

    GameState.load_day("res://days/day_infinite.gd")

func _event_onboarding() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/cm_onboarding_01.gd"
    )
    GameState.game_window.add_child(chat_window)


func _delay_event_onboarding02() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/cm_onboarding_02.gd"
    )
    await get_tree().create_timer(2).timeout
    GameState.game_window.add_child(chat_window)


func _delay_event_onboarding03() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/cm_onboarding_03.gd"
    )
    await get_tree().create_timer(2).timeout
    GameState.game_window.add_child(chat_window)


func _delay_event_onboarding04() -> void:
    OnboardingPCE02.fire()
    GameState.force_refresh()

    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/cm_onboarding_04.gd"
    )
    await get_tree().create_timer(2).timeout
    GameState.game_window.add_child(chat_window)


func _event_onboarding05() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/cm_onboarding_05.gd"
    )
    GameState.game_window.add_child(chat_window)


func _event_postmarket_chat_messages() -> void:
    GameState.is_onboarding = false

    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/day0_test_message2.gd"
    )
    GameState.game_window.add_child(chat_window)
