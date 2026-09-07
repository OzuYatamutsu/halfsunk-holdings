# EventSideEffects
extends Node

# Handles side effects associated with a ChatEvent.

static var GoldEventPass = PriceChangeEvent.new(
    {"XMAU": 1.40}, "Gold miners rejoice after discovery of new gold site in some guy's backyard!"
)

static var GoldEventFail = PriceChangeEvent.new(
    {"CAT": 0.85}, "Feline Mega Capital shares tumble today after star trader digs around in his backyard and accidentally discovers oil, soiling his expensive suit"
)

static var OptionsEventPass = PriceChangeEvent.new(
    {"CAT": 2.00}, "Star trader from Feline Mega Capital discovers options trading and becomes fabulously rich!!"
)

static var OptionsEventFail = PriceChangeEvent.new(
    {"CAT": 0.50}, "Feline Mega Capital shares collapse after trader discovers options trading, proceeds to lose half of the company's money"
)


func _init() -> void:
    GameState.chat_message_signal.connect(_handle_event_trigger)


func _handle_event_trigger(args: String) -> void:
    if args == "cm_random_coffee_yes":
        __cm_random_coffee_yes()
    elif args == "cm_random_gold_roll":
        __cm_random_gold_roll()
    elif args == "cm_random_options_roll":
        __cm_random_options_roll()


func __cm_random_coffee_yes() -> void:
    GameState.cash -= 100
    if GameState.cash < 0:
        GameState.cash = 0
    GameState.cash_changed.emit()
    GameState.recalculate_net_worth()
    GameState.force_refresh()


func __cm_random_gold_roll() -> void:
    if (randf() <= 0.2):
        GameState.current_day.events_to_fire.append(GoldEventPass)
    else:
        GameState.current_day.events_to_fire.append(GoldEventFail)


func __cm_random_options_roll() -> void:
    if (randf() <= 0.1):
        GameState.current_day.events_to_fire.append(OptionsEventPass)
    else:
        GameState.current_day.events_to_fire.append(OptionsEventFail)
