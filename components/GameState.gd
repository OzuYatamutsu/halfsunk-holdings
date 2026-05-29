# class_name GameState
extends Node

signal cash_changed
signal net_worth_changed


const BUILD_DATE: String = "20260529"
const VERSION_STRING: String = "0.4.11"
const SAVE_GAME_PATH_ROOT: String = "user://"
const SAVE_GAME_PATH_FOLDER: String = "savegames"
const SAVE_GAME_PATH: String = SAVE_GAME_PATH_ROOT + SAVE_GAME_PATH_FOLDER
const SAVE_GAME_PREFIX: String = "save"

const STARTING_CASH: float = 1000.0
const STARTING_NET_WORTH: float = 1000.0
const STARTING_DAY: int = 1

var save_slot: int = 0
var cash: float = 0.0
var portfolio: Portfolio = Portfolio.new()
var net_worth: float = 0.0
var total_score: float = 0.0
var target: float = 0.0
var current_day: Day
var day_count: int = 1
var is_in_phase_transition: bool = false

var game_window: GameWindow
var stock_market: StockMarket

## Use this to pass data between pages.
var switch_page_data_bus: Variant


func _init() -> void:
    _ensure_savegame_dir()


func clear_state() -> void:
    if stock_market:
        stock_market.queue_free()
    stock_market = StockMarket.new()
    cash = STARTING_CASH
    portfolio.clear()
    net_worth = STARTING_NET_WORTH
    day_count = STARTING_DAY
    total_score = 0.0
    target = 0.0
    switch_page_data_bus = ""

    PriceMovementsRandom.repopulateEvents()


func start_day() -> void:
    switch_page_data_bus = ""
    cash_changed.emit()
    net_worth_changed.emit()
    game_window.hud_status.update()


func end_day() -> void:
    pass


func recalculate_net_worth() -> void:
    net_worth = cash + portfolio.value()
    net_worth_changed.emit()


func get_time() -> String:
    if (!current_day):
        return "08:00"
    if (current_day.phase == Day.Phase.PREMARKET):
        return "08:30"
    elif (current_day.phase == Day.Phase.MARKETOPEN):
        return "%s:00" % [str(
            Day.MARKETOPEN_START_HOUR + current_day.action_count
        ).pad_zeros(2)]
    elif (current_day.phase == Day.Phase.AFTERMARKET):
        return "17:00"
    else:  # Day.Phase.CLOSE
        return "18:00"


## e.g. day 1, action 5 = 5, day 2, action 2 = 10
func get_current_timestamp() -> int:
    if (current_day):
        return (day_count * Day.MARKETOPEN_ACTION_COUNT) + current_day.action_count
    else:
        return (day_count * Day.MARKETOPEN_ACTION_COUNT)


## "Monday, 12:00"
func get_current_timestamp_humanized() -> String:
    if (current_day):    
        return "%s, %s" % [Day.DayOfWeek.keys()[current_day.day], get_time()]
    else:
        return "Day %s, %s" % [day_count, get_time()]


## Call this to trigger an end of week state
func end_of_week() -> void:
    print("end of week calculation start")

    # Scene with end of week animations
    var _end_of_week_anim: PhaseTransitionAnim = load("res://components/EndOfWeekAnim.tscn").instantiate()
    current_day.add_child(_end_of_week_anim)
    await _end_of_week_anim.animation_complete
    
    print("net worth: %.2d, target: %.2d" % [net_worth, target])
    if (net_worth < target):
        print("entering eow losing state")
    else:
        print("entering eow winning state")
        
        # Clear out all investments in prep for next week
        cash = 0.0
        net_worth = 0.0
        target = 0.0
        portfolio.clear()
        
        save_game()


func _ensure_savegame_dir() -> void:
    var save_game_dir = DirAccess.open(GameState.SAVE_GAME_PATH)
    if save_game_dir != null:
        return

    print("Save game dir doesn't exist, creating")
    DirAccess.open(GameState.SAVE_GAME_PATH_ROOT).make_dir(GameState.SAVE_GAME_PATH_FOLDER)
    save_game_dir = DirAccess.open(GameState.SAVE_GAME_PATH)


## Games will be saved in ${SAVE_GAME_PATH}/${SAVE_PREFIX}_${save_slot}.
func save_game() -> void:
    var full_save_path = "%s/%s_%s" % [SAVE_GAME_PATH, SAVE_GAME_PREFIX, save_slot]
    var save_file = FileAccess.open(full_save_path, FileAccess.WRITE)
    print("Saving game to %s..." % [full_save_path])

    # Save data
    var _save_data_header: String = "%s %s %s" % [day_count, current_day.day, total_score]
    var _gamestate_data: String = serialize()

    save_file.store_line(_save_data_header)
    save_file.store_line(_gamestate_data)
    print("Saved.")


func load_game(save_game_path: String) -> void:
    var save_file = FileAccess.open(save_game_path, FileAccess.READ)
    print("Loading game from %s..." % [save_game_path])

    var _save_data_header: String = save_file.get_line()
    var _gamestate_data: String = save_file.get_line()

    print(
        "[load_game] day %s, dow %s, total_score %s" % [
            _save_data_header.split(" ")[0],
            _save_data_header.split(" ")[1],
            _save_data_header.split(" ")[2]
        ]
    )

    deserialize(_gamestate_data)
    print("[load_game] restored gamestate, loading level...")
    get_tree().change_scene_to_file(GameState.current_day.scene_path)


func serialize() -> String:
    return JSON.stringify({
        "save_slot": save_slot,
        "cash": cash,
        "portfolio": portfolio.serialize(),
        "net_worth": net_worth,
        "total_score": total_score,
        "target": target,
        "current_day": current_day.serialize(),
        "day_count": day_count,
        "stock_market": stock_market.serialize()
    })


func deserialize(json: String) -> void:
    var _data_obj = JSON.parse_string(json)

    save_slot = _data_obj.save_slot
    cash = _data_obj.cash
    portfolio = Portfolio.deserialize(_data_obj.portfolio)
    net_worth = _data_obj.net_worth
    total_score = _data_obj.total_score
    target = _data_obj.target
    current_day = Day.deserialize(_data_obj.current_day)
    day_count = _data_obj.day_count
    stock_market = StockMarket.deserialize(_data_obj.stock_market)
