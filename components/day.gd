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
    START = -1,
    PREMARKET = 0,
    MARKETOPEN = 1,
    AFTERMARKET = 2,
    CLOSE = 3
}

## Emitted after the last event fires in Phase.PREMARKET
## or Phase.AFTERMARKET.
signal last_event_finished

## Emitted after an action is taken in Phase.MARKETOPEN.
signal action_taken


const PREMARKET_START_ANIM: PackedScene = preload("res://components/PremarketStartAnim.tscn")
const MARKETOPEN_START_ANIM: PackedScene = preload("res://components/MarketOpenStartAnim.tscn")
const AFTERMARKET_START_ANIM: PackedScene = preload("res://components/AfterMarketStartAnim.tscn")
const CLOSE_START_ANIM: PackedScene = preload("res://components/CloseStartAnim.tscn")


## How many actions are in Phase.MARKETOPEN?
const MARKETOPEN_ACTION_COUNT: int = 8

const MARKETOPEN_START_HOUR: int = 9
const MARKETOPEN_PHASE_TRANSITION_DELAY_SECS: float = 0.5


## Events are called at the start of each phase.
## Events are ordered. To have multiple events occur
## in a phase, pass in a callable which calls another
## callable at the end of execution.
var events: Dictionary[Phase, Callable] = {}

## Which day of the week is this level?
var day: DayOfWeek

## What phase are we currently on?
var phase: Phase = Phase.START

## What's our current action count?
## (Only relevant in Phase.MARKETOPEN)
var action_count: int = 0


func _ready() -> void:
    GameState.current_day = self
    last_event_finished.connect(start_next_phase)

    last_event_finished.connect(GameState.game_window.hud_status.update)
    action_taken.connect(GameState.game_window.hud_status.update)


func start_next_phase() -> void:
    if (phase == Phase.START):
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


## Take an action and advance time forward.
## Only done in Phase.MARKETOPEN.
func take_action():
    assert(phase == Phase.MARKETOPEN)

    action_count += 1
    print("actions taken: %s/%s" % [
        action_count, MARKETOPEN_ACTION_COUNT
    ])
    action_taken.emit()

    # Gives some time for things to update, then
    # phase transition if necessary
    await get_tree().create_timer(
        MARKETOPEN_PHASE_TRANSITION_DELAY_SECS
    ).timeout
    if action_count == MARKETOPEN_ACTION_COUNT:
        start_next_phase()


func on_premarket_start() -> void:
    GameState.clear_state()
    GameState.start_day()
    
    # Play starting animation
    var _anim: PhaseTransitionAnim = PREMARKET_START_ANIM.instantiate()
    get_tree().current_scene.add_child(_anim)
    await _anim.animation_complete

    if Phase.PREMARKET in events:
        events[Phase.PREMARKET].call()


func on_premarket_end() -> void:
    pass


func on_marketopen_start() -> void:
    # Play starting animation
    var _anim: PhaseTransitionAnim = MARKETOPEN_START_ANIM.instantiate()
    get_tree().current_scene.add_child(_anim)
    await _anim.animation_complete

    if Phase.MARKETOPEN in events:
        events[Phase.MARKETOPEN].call()


func on_marketopen_end() -> void:
    pass


func on_aftermarket_start() -> void:
    # Play starting animation
    var _anim: PhaseTransitionAnim = AFTERMARKET_START_ANIM.instantiate()
    get_tree().current_scene.add_child(_anim)
    await _anim.animation_complete

    if Phase.AFTERMARKET in events:
        events[Phase.MARKETOPEN].call()
    

func on_aftermarket_end() -> void:
    pass


func on_close_start() -> void:
    # Play starting animation
    var _anim: PhaseTransitionAnim = CLOSE_START_ANIM.instantiate()
    get_tree().current_scene.add_child(_anim)
    await _anim.animation_complete

    if Phase.CLOSE in events:
        events[Phase.CLOSE].call()


func on_close_end() -> void:
    pass
