# week 0, day 2
extends Day

const DAY02_COFFEE_FORCED_EVENT_CHANCE = 0.85
static var Day02CoffeeForcedEvent = PriceChangeEvent.new(
    {"JINH": 0.95}, "President of Jinhai Holdings takes off early and flies to Brexico to address a minor burn injury, commenting: 'i aint payin for no $5000 ambulance'"
)


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


func on_marketopen_start() -> void:
    super()
    if randf() <= DAY02_COFFEE_FORCED_EVENT_CHANCE:
        print("day0002: roll pass, queuing Day02CoffeeForcedEvent")
        events_to_fire.append(Day02CoffeeForcedEvent)


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
