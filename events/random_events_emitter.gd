class_name RandomEventsEmitter
extends Node


## These aren't associated with story events, and can be inserted
## in any day.


static var CatInsideTrading01: String = "res://events/cm_random_cat_inside_trading01.txt"
static var MewEvent01: String = "res://events/cm_random_mew_event01.txt"
static var RandomGold01: String = "res://events/cm_random_gold01.txt"
static var OptionsTrading01: String = "res://events/cm_random_options01.txt"
static var ParasolVirus01: String = "res://events/cm_random_parasol_virus01.txt"
static var CoffeeEvent01: String = "res://events/cm_random_coffee01.txt"

static var EventsNotFired: Array[String]


## Reset events schedule.
static func repopulateEvents() -> void:
    EventsNotFired = [
        CatInsideTrading01, MewEvent01, RandomGold01,
        OptionsTrading01, ParasolVirus01, CoffeeEvent01
    ]


## Returns true if we can return a random event.
static func hasUnfiredRandomEvents() -> bool:
    return !EventsNotFired.is_empty()


## Returns a random, unfired event. 
static func returnRandomEvent() -> ChatWindowModal:
    EventsNotFired.shuffle()
    return ChatEventParser.load_chatevent_from_file(
        EventsNotFired.pop_front()
    )
