class_name TickerTape
extends Control

const DUMMY_TEXT := "CAT 223.25 ↗ 22.05 (+10.96%)  |  BIRD 415.28 ↗ 22.05 (+5.61%)  |  DOG 15.26 ↘ 1.06 (−6.50%)  |  CRW 12.48 ↘ 1.14 (−8.37%)  |  SNEK 66.66 ↗ 0.22 (+0.33%)  |  "

@export var speed_px_per_sec: float = 100.0
@export var text: String = ""
@export var dummy_mode: bool = true

@onready var _label: Label = %Label
@onready var _label2: Label = %Label2

## Simulates infinite scrolling text using two
## repeated labels which loop back on top of
## each other when it gets to the edge of the
## screen.

var _running := true

func _ready():
    if dummy_mode:
        text = (DUMMY_TEXT)

    await _apply_text()
    _reset_positions()


func set_text_from_stock_market_data() -> void:
    _running = false

    # capture BOTH positions
    var x1 := _label.position.x
    var x2 := _label2.position.x

    text = "    |   ".join(GameState.stock_market.get_all_to_string())
    text += "  |"
    await _apply_text()

    # restore positions exactly
    _label.position.x = x1
    _label2.position.x = x2

    # NOW fix spacing depending on which is leading
    if _label.position.x < _label2.position.x:
        _label2.position.x = _label.position.x + _label.size.x
    else:
        _label.position.x = _label2.position.x + _label2.size.x

    speed_px_per_sec = _label.size.x / 10.0

    _running = true

func _apply_text():
    _label.text = text
    _label2.text = text

    await get_tree().process_frame
    speed_px_per_sec = _label.size.x / 10.0

func _reset_positions():
    _label.position.x = 0
    _label2.position.x = _label.size.x

func set_text(new_text: String):
    text = new_text

    var prev_x := _label.position.x

    await _apply_text()

    _label.position.x = prev_x
    _label2.position.x = _label.position.x + _label.size.x

func _process(delta: float):
    if !_running:
        return

    var dx := speed_px_per_sec * delta

    _label.position.x -= dx
    _label2.position.x -= dx

    # when label exits left, recycle it
    if _label.position.x + _label.size.x < 0:
        _label.position.x = _label2.position.x + _label2.size.x

    if _label2.position.x + _label2.size.x < 0:
        _label2.position.x = _label.position.x + _label.size.x

func start():
    _running = true

func stop():
    _running = false
