class_name RandomEventsEmitter
extends Node


## These aren't associated with story events, and can be inserted
## in any day.


static var CatInsideTrading01: String = "res://events/cm_random_cat_inside_trading01.gd"
static var MewEvent01: String = "res://events/cm_random_mew_event01.gd"

static var EventsNotFired: Array[String]


## Reset events schedule.
static func repopulateEvents() -> void:
    EventsNotFired = [
        CatInsideTrading01, MewEvent01
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
