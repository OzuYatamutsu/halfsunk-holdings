class_name RandomEventsEmitter
extends Node


## These aren't associated with story events, and can be inserted
## in any day.


static var CatInsideTrading01: ChatWindowModal = load(
    "res://events/cm_random_cat_inside_trading01.gd"
).instantiate()


static var EventsNotFired: Array[ChatWindowModal]


## Reset events schedule.
static func repopulateEvents() -> void:
    EventsNotFired = [
        CatInsideTrading01
    ]


## Returns true if we can return a random event.
static func hasUnfiredRandomEvents() -> bool:
    return !EventsNotFired.is_empty()


## Returns a random, unfired event. 
static func returnRandomEvent() -> ChatWindowModal:
    EventsNotFired.shuffle()
    return EventsNotFired.pop_front()
