class_name RandomEventsEmitter
extends Node


## These aren't associated with story events, and can be inserted
## in any day.


static var CatInsideTrading01: String = "res://events/cm_random_cat_inside_trading01.gd"
static var MewEvent01: String = "res://events/cm_random_mew_event01.gd"
static var RandomGold01: String = "res://events/cm_random_gold01.gd"
static var OptionsTrading01: String = "res://events/cm_random_options01.gd"
static var ParasolVirus01: String = "res://events/cm_random_parasol_virus01.gd"
static var CoffeeEvent01: String = "res://events/cm_random_coffee01.gd"

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
    return ChatWindowModal.Create(
        EventsNotFired.pop_front()
    )
