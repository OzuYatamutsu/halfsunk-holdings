class_name TickerTape
extends Control

const DUMMY_TEXT: String = "CAT 223.25 ↗ 22.05 (+10.96%)  |   BIRD 415.28 ↗ 22.05 (+5.61%)  |   DOG 15.26 ↘ 1.06 (−6.50%)    |   LZRD 225.14 ↗ 15.45 (+7.37%)    |   TIGR 12.68 (↗ 2.01) (+15.85%)   | "

@export var text: String = ""
@export var interval_secs: float = 10.0

## If true, set text = dummy text.
@export var dummy_mode: bool = true

@onready var _label: Label = %Label
@onready var _label2: Label = %Label2

## If true, marquee will play only once.
var should_stop: bool = false

## Simulates infinite scrolling text using two
## repeated labels which loop back on top of
## each other when it gets to the edge of the
## screen.

var _tween: Tween
var _tween2: Tween

func _ready() -> void:
    if (dummy_mode):
        text = DUMMY_TEXT
    update()

func set_text_from_stock_market_data() -> void:
    set_text("    |   ".join(GameState.stock_market.get_all_to_string()), false)

func unset_dummy_mode() -> void:
    dummy_mode = false
    set_text("", true)

func set_dummy_mode() -> void:
    dummy_mode = true
    set_text(DUMMY_TEXT, false)

## new_should_stop = loops once, !new_should_stop = loops infinitely
func set_text(new_text: String, new_should_stop: bool) -> void:
    text = new_text
    should_stop = new_should_stop
    update(false)

func update(should_restart_tween=true) -> void:
    if _tween and should_restart_tween:
        _tween.stop()
        _tween.kill()
    if _tween2 and should_restart_tween:
        _tween2.stop()
        _tween2.kill()

    _label.text = text
    _label2.text = text
    
    if !_tween or !_tween.is_running():
        _tween = create_tween()
        _tween.tween_property(
            _label, "position:x", -_label.size.x, interval_secs
        ).from(_label.position.x)
    if !_tween2 or !_tween2.is_running():
        _tween2 = create_tween()
        _tween2.tween_property(
            _label2, "position:x", _label.position.x, interval_secs
        ).from(_label2.position.x)

    if (!should_stop):
        _tween = _tween.set_loops()
        _tween2 = _tween2.set_loops()


func start():
    _tween.play()
    _tween2.play()

func stop():
    _tween.stop()
    _tween2.stop()
