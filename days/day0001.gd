# week 0, day 1
extends Day

const WEEKLY_GOAL: float = 2000.0

static var OnboardingPCE01 = PriceChangeEvent.new(
    {"CAT": 0.90}, "Civet Coffees press charges against CAT for ‘culture of unlicensed coffee consumption’. CAT shares tumble!"
)

static var OnboardingPCE02 = PriceChangeEvent.new(
    {"CAT": 1.10}, ""
)


func _ready() -> void:
    # First day of week
    GameState.clear_state()
    GameState.target = WEEKLY_GOAL
    GameState.chat_message_signal.connect(_on_chat_message_signal)

    day = Day.DayOfWeek.MONDAY
    events = {
        Day.Phase.PREMARKET: _event_onboarding
    }

    # Treats some behaviour differently
    GameState.is_onboarding = true

    GameState.game_window.command_prompt.command_fired.connect(
        _on_command_fired
    )
    super()
    start_next_phase()


func on_action_taken() -> void:
    if action_count == 1 and phase == Phase.PREMARKET:
        _delay_event_onboarding04()
    if action_count == 2 and phase == Phase.PREMARKET:
        _event_onboarding05()
    if action_count == 2 and phase == Phase.MARKETOPEN:
        print("DEBUG")
        ChatEventParser.load_chatevent_from_file("res://events/cm_random_coffee01.txt").fire()


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
    ChatEventParser.load_chatevent_from_file(
        "res://events/cm_onboarding_01.txt"
    ).fire()


func _delay_event_onboarding02() -> void:
    await get_tree().create_timer(2).timeout
    ChatEventParser.load_chatevent_from_file(
        "res://events/cm_onboarding_02.txt"
    ).fire()


func _delay_event_onboarding03() -> void:
    OnboardingPCE01.fire()
    GameState.force_refresh()
    await get_tree().create_timer(2).timeout
    ChatEventParser.load_chatevent_from_file(
        "res://events/cm_onboarding_03.txt"
    ).fire()


func _delay_event_onboarding04() -> void:
    OnboardingPCE02.fire()
    GameState.force_refresh()
    await get_tree().create_timer(2).timeout
    ChatEventParser.load_chatevent_from_file(
        "res://events/cm_onboarding_04.txt"
    ).fire()


func _event_onboarding05() -> void:
    ChatEventParser.load_chatevent_from_file(
        "res://events/cm_onboarding_05.txt"
    ).fire()


func _event_onboarding_post() -> void:
    GameState.is_onboarding = false
    GameState.current_day.start_next_phase()
    action_count = 0


func _on_chat_message_signal(args) -> void:
    if args == "1":
        _delay_event_onboarding03()
    else:
        _event_onboarding_post()
