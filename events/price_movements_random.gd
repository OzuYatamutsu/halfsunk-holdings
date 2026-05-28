class_name PriceMovementsRandom
extends Node

## These aren't associated with story events, and can be inserted
## in any day.


var NationalMilkDay = PriceChangeEvent.new(
    # Increase the price of all cat stocks
    {"CAT": 1.05, "TIGR": 1.05, "EZBV": 1.10, "EZBD": 1.10, "XMAU": 1.35}, "It's National Milk Day! Consumers are going nuts and buying up all the milk!"
)

var NationalDogDay = PriceChangeEvent.new(
    # All cat stocks go down, all dog stocks go up
    {"JINH": 0.90, "CAT": 0.90, "DOG": 1.10, "EZBD": 0.90, "EZBV": 0.90, "TIGR": 0.95, "XMAU": 0.75}, "It's National Dog Day! People are selling their cats en masse!"
)

var NewInflationNumbersBad = PriceChangeEvent.new(
    # Everything goes down except gold
    {"JINH": 0.90, "CAT": 0.90, "DOG": 0.90, "BIRD": 0.90, "LZRD": 0.90, "TIGR": 0.90, "EZBV": 0.90, "EZBD": 0.90, "CBLT": 0.90, "MSTR": 0.90, "CRW": 0.90, "SNEK": 0.90, "XMAU": 1.50}, "Oh, no! The newest inflation numbers have been released, and it's bad!!"
)

var NewInflationNumbersGood = PriceChangeEvent.new(
    # Everything goes up except gold
    {"JINH": 1.10, "CAT": 1.10, "DOG": 1.10, "BIRD": 1.10, "LZRD": 1.10, "TIGR": 1.10, "EZBV": 1.10, "EZBD": 1.10, "CBLT": 1.10, "MSTR": 1.10, "CRW": 1.10, "SNEK": 1.10, "XMAU": 0.75}, "Aw, neat! The newest inflation numbers have been released, and it's good!!"
)

var PoliticianIceCreamSubsidy = PriceChangeEvent.new(
    # Increase the price of all cat stocks
    {"CAT": 1.05, "TIGR": 1.05, "EZBV": 1.10, "EZBD": 1.10, "XMAU": 1.35}, "A local politician has introduce a new subsidy on ice cream! Dairy enjoyers rejoice!"
)

var DogCryptoInsiderTrading = PriceChangeEvent.new(
    {"DOG": 0.90}, "Scandal! An employee of Canine Energy was accused of insider trading!"
)

var CrowFactoryRelease = PriceChangeEvent.new(
    {"CRW": 1.10}, "Corvid Auto confirms the opening of a new factory on the Southern Islands."
)

var DogPlotThwarted = PriceChangeEvent.new(
    # Decrease dog stocks
    {"DOG": 0.90}, "A nasty price collusion plot by DOGS was discovered by the Chief Investigator! Better luck next time!!"
)

var EventsNotFired: Array[PriceChangeEvent]


func _ready() -> void:
    repopulateEvents()


## Reset events schedule.
func repopulateEvents() -> void:
    EventsNotFired = [
        NationalMilkDay, NationalDogDay,
        NewInflationNumbersBad, NewInflationNumbersGood,
        PoliticianIceCreamSubsidy, DogCryptoInsiderTrading,
        CrowFactoryRelease, DogPlotThwarted, 
    ]


## Returns true if we can return a random event.
func hasUnfiredRandomEvents() -> bool:
    return !EventsNotFired.is_empty()


## Returns a random, unfired event. 
func returnRandomEvent() -> PriceChangeEvent:
    EventsNotFired.shuffle()
    return EventsNotFired.pop_front()
