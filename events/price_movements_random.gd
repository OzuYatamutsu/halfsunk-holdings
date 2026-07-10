class_name PriceMovementsRandom
extends Node

## These aren't associated with story events, and can be inserted
## in any day.


static var NationalMilkDay = PriceChangeEvent.new(
    # Increase the price of all cat stocks
    {"CAT": 1.05, "TIGR": 1.05, "EZBV": 1.10, "EZBD": 1.10, "XMAU": 1.35}, "It's National Milk Day! Consumers are going nuts and buying up all the milk!"
)

static var NationalDogDay = PriceChangeEvent.new(
    # All cat stocks go down, all dog stocks go up
    {"JINH": 0.90, "CAT": 0.90, "DOG": 1.10, "EZBD": 0.90, "EZBV": 0.90, "TIGR": 0.95, "XMAU": 0.75}, "It's National Dog Day! People are selling their cats en masse!"
)

static var NewInflationNumbersBad = PriceChangeEvent.new(
    # Everything goes down except gold
    {"JINH": 0.90, "CAT": 0.90, "DOG": 0.90, "BIRD": 0.90, "LZRD": 0.90, "TIGR": 0.90, "EZBV": 0.90, "EZBD": 0.90, "CBLT": 0.90, "MSTR": 0.90, "CRW": 0.90, "SNEK": 0.90, "XMAU": 1.50}, "Oh, no! The newest inflation numbers have been released, and it's bad!!"
)

static var NewInflationNumbersGood = PriceChangeEvent.new(
    # Everything goes up except gold
    {"JINH": 1.10, "CAT": 1.10, "DOG": 1.10, "BIRD": 1.10, "LZRD": 1.10, "TIGR": 1.10, "EZBV": 1.10, "EZBD": 1.10, "CBLT": 1.10, "MSTR": 1.10, "CRW": 1.10, "SNEK": 1.10, "XMAU": 0.75}, "Aw, neat! The newest inflation numbers have been released, and it's good!!"
)

static var PoliticianIceCreamSubsidy = PriceChangeEvent.new(
    # Increase the price of all cat stocks
    {"CAT": 1.05, "TIGR": 1.05, "EZBV": 1.10, "EZBD": 1.10, "XMAU": 1.35}, "A local politician has introduced a new subsidy on ice cream! Dairy enjoyers rejoice!"
)

static var DogCryptoInsiderTrading = PriceChangeEvent.new(
    {"DOG": 0.90}, "Scandal! An employee of Canine Energy was accused of insider trading!"
)

static var CrowFactoryRelease = PriceChangeEvent.new(
    {"CRW": 1.10}, "Corvid Auto confirms the opening of a new factory on the Southern Islands."
)

static var DogPlotThwarted = PriceChangeEvent.new(
    # Decrease dog stocks
    {"DOG": 0.90}, "A nasty price collusion plot by DOGS was discovered by the Chief Investigator! Better luck next time!!"
)

static var CarExplosionTest = PriceChangeEvent.new(
    {"CRW": 0.70}, "Disaster! Corvid Auto's new car exploded at the test track!!"
)

static var CrimePlot1 = PriceChangeEvent.new(
    # Everything goes down
    {"JINH": 0.95, "CAT": 0.95, "DOG": 0.95, "BIRD": 0.95, "LZRD": 0.95, "TIGR": 0.95, "EZBV": 0.95, "EZBD": 0.95, "CBLT": 0.95, "MSTR": 0.95, "CRW": 0.95, "SNEK": 0.95, "XMAU": 0.95}, "The GANG OF EXTORTIONISTS sent a letter to the central government, and it's scary!!"
)

static var CrimePlot2 = PriceChangeEvent.new(
    # Gold goes down a lot
    {"XMAU": 0.60}, "The central government arrested an official with 999 million dollars of gold smuggled in his house!"
)

static var CrimePlot3 = PriceChangeEvent.new(
    # No change
    {}, "The mastermind behind a recent failed attack plot against a famous concert apologized in federal court today."
)

static var HighSalaryInvestment1 = PriceChangeEvent.new(
    # JINH, CAT, MSTR all drop by 10%
    {"JINH": 0.90, "CAT": 0.90, "MSTR": 0.90}, "Investment managers report record high salaries, and investors are real mad!"
)

static var AlcoholLust1 = PriceChangeEvent.new(
    # EZBV increases 10%
    {"EZBV": 1.10}, "Latest consumer report -- we LOVE drinking ALCOHOL!"
)

static var ComfySleepEvent1 = PriceChangeEvent.new(
    # EZBD increases 10%
    {"EZBD": 1.10}, "Leading scientists express support for a comfy night's sleep..."
)

static var SummerOfFurnishingsEvent1 = PriceChangeEvent.new(
    # LZRD increases 10%
    {"LZRD": 1.10}, "Top style magazine declares this summer to be the summer of home furnishings!"
)

static var BiotechEscape1 = PriceChangeEvent.new(
    # CBLT decreases 20%, MSTR, LZRD, and SNEK decreases 10%
    {"CBLT": 0.80, "MSTR": 0.90, "LZRD": 0.90, "SNEK": 0.90}, "Virus escapes biotech lab, but only affects reptiles"
)

static var FailClinicalTrials1 = PriceChangeEvent.new(
    # CBLT decreases 10%
    {"CBLT": 0.90}, "Latest drug that turns you into your fursona fails stage 2 clinical trials"
)

static var CanineEnergySleep1 = PriceChangeEvent.new(
    # DOG decreases 10%
    {"DOG": 0.90}, "Why do people keep falling asleep after drinking CANINE ENERGY'S latest soft drink?"
)

static var AvianPoopFine1 = PriceChangeEvent.new(
    # BIRD decreases 10%
    {"BIRD": 0.90}, "Avian Express fined $1.3B over waste dumping concerns over its delivery routes"
)

static var InformationalPlot1 = PriceChangeEvent.new(
    # No change
    {}, "MOON NEWS: A rare BLUE MOON rises this weekend!"
)

static var InformationalPlot2 = PriceChangeEvent.new(
    # No change
    {}, "Cleaning your fan? Experts say avoid this common mistake! ..."
)

static var InformationalPlot3 = PriceChangeEvent.new(
    # No change
    {}, "CELEBRITY NEWS: 'How I travel without my child, and why you should too! (Just sell them!)'"
)

static var InformationalPlot4 = PriceChangeEvent.new(
    # No change
    {}, "My dog learned this one cool shower trick!"
)

static var InformationalPlot5 = PriceChangeEvent.new(
    # No change
    {}, "Coal mine sued over childcare injuries -- spokesperson says, 'Stop suing and get back to work!!'"
)

static var InformationalPlot6 = PriceChangeEvent.new(
    # No change
    {}, "She grew up with 37 siblings -- local rabbit shares her story"
)

static var InformationalPlot7 = PriceChangeEvent.new(
    # No change
    {}, "Another super weather event is coming, local global warming enthusiasts rejoice"
)

static var InformationalPlot8 = PriceChangeEvent.new(
    # No change
    {}, "Study suggests mysterious brain contraction in small, terrible dogs"
)

static var EventsNotFired: Array[PriceChangeEvent]


## Reset events schedule.
static func repopulateEvents() -> void:
    EventsNotFired = [
        NationalMilkDay, NationalDogDay,
        NewInflationNumbersBad, NewInflationNumbersGood,
        PoliticianIceCreamSubsidy, DogCryptoInsiderTrading,
        CrowFactoryRelease, DogPlotThwarted, CarExplosionTest,
        CrimePlot1, CrimePlot2, CrimePlot3, HighSalaryInvestment1,
        AlcoholLust1, ComfySleepEvent1, SummerOfFurnishingsEvent1,
        BiotechEscape1, FailClinicalTrials1, CanineEnergySleep1,
        AvianPoopFine1. InformationalPlot1, InformationalPlot2,
        InformationalPlot3, InformationalPlot4, InformationalPlot5,
        InformationalPlot6, InformationalPlot7, InformationalPlot8
    ]


## Returns true if we can return a random event.
static func hasUnfiredRandomEvents() -> bool:
    return !EventsNotFired.is_empty()


## Returns a random, unfired event. 
static func returnRandomEvent() -> PriceChangeEvent:
    EventsNotFired.shuffle()
    return EventsNotFired.pop_front()
