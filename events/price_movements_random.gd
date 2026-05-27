class_name PriceMovementsRandom
extends Node

## These aren't associated with story events, and can be inserted
## in any day.

var NationalMilkDay = PriceChangeEvent.new(
    {"CAT": 1.05, "TIGR": 1.05, "EZBV": 1.10}, "It's National Milk Day! Consumers are going nuts and buying up all the milk!"
)

var NationalDogDay = PriceChangeEvent.new(
    {"JINH": 0.90, "CAT": 0.90, "DOG": 1.10, "TIGR": 0.95}, "It's National Dog Day! People are selling their cats en masse!"
)

var EventsNotFired: Array[PriceChangeEvent]


func _ready() -> void:
    repopulateEvents()


## Reset events schedule.
func repopulateEvents() -> void:
    EventsNotFired = [
        NationalMilkDay, NationalDogDay
    ]


## Returns true if we can return a random event.
func hasUnfiredRandomEvents() -> bool:
    return !EventsNotFired.is_empty()


## Returns a random, unfired event. 
func returnRandomEvent() -> PriceChangeEvent:
    EventsNotFired.shuffle()
    return EventsNotFired.pop_front()
