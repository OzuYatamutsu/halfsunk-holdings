class_name Day
extends Node

## A Day is split into four phases, PreMarket, MarketOpen,
## AfterMarket, and Close. Events occur during each
## day during each phase, and time advances when conditions
## within each phase are met.


enum DayOfWeek {
    MONDAY = 0,
    TUESDAY = 1,
    WEDNESDAY = 2,
    THURSDAY = 3,
    FRIDAY = 4
}


enum Phase {
    PREMARKET = 0,
    MARKETOPEN = 1,
    AFTERMARKET = 2,
    CLOSE = 3
}


const PREMARKET_START_ANIM: PackedScene = preload("res://components/PremarketStartAnim.tscn")
const MARKETOPEN_START_ANIM: PackedScene = preload("res://components/MarketOpenStartAnim.tscn")
const AFTERMARKET_START_ANIM: PackedScene = preload("res://components/AfterMarketStartAnim.tscn")
const CLOSE_START_ANIM: PackedScene = preload("res://components/CloseStartAnim.tscn")


## Events are called at the start of each phase.
## Events are ordered. To have multiple events occur
## in a phase, pass in a callable which calls another
## callable at the end of execution.
var events: Dictionary[Phase, Callable] = {}


## Which day of the week is this level?
var day: DayOfWeek

## What phase are we currently on?
var phase: Phase


func _ready() -> void:
    GameState.current_day = self
    start_next_phase()


func start_next_phase() -> void:
    if (!phase):
        print("phase transition: start -> premarket")
        phase = Phase.PREMARKET
        on_premarket_start()
    elif (phase == Phase.PREMARKET):
        print("phase transition: premarket -> marketopen")
        on_premarket_end()
        phase = Phase.MARKETOPEN
        on_marketopen_start()
    elif (phase == Phase.MARKETOPEN):
        print("phase transition: marketopen -> aftermarket")
        on_marketopen_end()
        phase = Phase.AFTERMARKET
        on_aftermarket_start()
    elif (phase == Phase.AFTERMARKET):
        print("phase transition: aftermarket -> close")
        phase = Phase.CLOSE
        on_close_start()
    elif (phase == Phase.CLOSE):
        print("phase transition: close -> end")
        on_close_end()

func on_premarket_start() -> void:
    GameState.clear_state()
    GameState.start_day()
    
    # Play starting animation
    var _anim: PhaseTransitionAnim = PREMARKET_START_ANIM.instantiate()
    get_tree().add_child(_anim)
    await _anim.animation_finished

    if Phase.PREMARKET in events:
        events[Phase.PREMARKET].call()


func on_premarket_end() -> void:
    pass


func on_marketopen_start() -> void:
    # Play starting animation
    var _anim: PhaseTransitionAnim = MARKETOPEN_START_ANIM.instantiate()
    get_tree().add_child(_anim)
    await _anim.animation_finished

    if Phase.MARKETOPEN in events:
        events[Phase.MARKETOPEN].call()


func on_marketopen_end() -> void:
    pass


func on_aftermarket_start() -> void:
    # Play starting animation
    var _anim: PhaseTransitionAnim = AFTERMARKET_START_ANIM.instantiate()
    get_tree().add_child(_anim)
    await _anim.animation_finished

    if Phase.AFTERMARKET in events:
        events[Phase.MARKETOPEN].call()
    

func on_aftermarket_end() -> void:
    pass


func on_close_start() -> void:
    # Play starting animation
    var _anim: PhaseTransitionAnim = CLOSE_START_ANIM.instantiate()
    get_tree().add_child(_anim)
    await _anim.animation_finished

    if Phase.CLOSE in events:
        events[Phase.CLOSE].call()


func on_close_end() -> void:
    pass
