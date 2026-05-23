class_name FakeTickerTape
extends Control

const DUMMY_TEXT := "CAT 223.25 ↗ 22.05 (+10.96%)  |  BIRD 415.28 ↗ 22.05 (+5.61%)  |  DOG 15.26 ↘ 1.06 (−6.50%)  |  CRW 12.48 ↘ 1.14 (−8.37%)  |  SNEK 66.66 ↗ 0.22 (+0.33%)  |  TIGR 21.14 ↗ 0.22 (+1.05%)  |  LZRD 67.69 ↗ 0.69 (+1.03%)  |  "

@export var speed_px_per_sec: float = 100.0

@onready var _label: Label = %Label
@onready var _label2: Label = %Label2

## Simulates infinite scrolling text using two
## repeated labels which loop back on top of
## each other when it gets to the edge of the
## screen.

var _running := true

func _ready():
    await _apply_text()
    _reset_positions()

func _apply_text():
    _label.text = DUMMY_TEXT
    _label2.text = DUMMY_TEXT

    await get_tree().process_frame
    speed_px_per_sec = _label.size.x / 10.0

func _reset_positions():
    _label.position.x = 0
    _label2.position.x = _label.size.x

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
