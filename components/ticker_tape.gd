class_name TickerTape
extends Control

const DUMMY_TEXT: String = "CAT 223.25 ↗ 22.05 (+10.96%)   |   BIRD 415.28 ↗ 22.05 (+5.61%)   |   DOG 15.26 ↘ 1.06 (−6.50%)    |   LZRD 225.14 ↗ 15.45 (+7.37%)   |   TIGR 12.68 (↗ 2.01) (+15.85%)   |   "
const SEPARATOR: String = "   |   "

@export var text: String = ""
@export var interval_secs: float = 10.0

## If true, set text = dummy text.
@export var dummy_mode: bool = true

@onready var marquee: Marquee = %Marquee

## If true, marquee will play only once.
var should_stop: bool = false

var _inited: bool = false

## Simulates infinite scrolling text using two
## repeated labels which loop back on top of
## each other when it gets to the edge of the
## screen.


func _ready() -> void:
    if (dummy_mode):
        text = DUMMY_TEXT

func set_text_from_stock_market_data() -> void:
    if !_inited:
        set_text(SEPARATOR.join(GameState.stock_market.get_all_to_string()), false)
        _inited = true
    else:
        update_text(SEPARATOR.join(GameState.stock_market.get_all_to_string()))

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
    marquee.lines = [
        new_text.trim_suffix(" ") + SEPARATOR,
        new_text.trim_suffix(" ") + SEPARATOR
    ]

func update_text(new_text: String) -> void:
    text = new_text
    marquee._labels[0].text = new_text.trim_suffix(" ") + SEPARATOR
    marquee._labels[1].text = new_text.trim_suffix(" ") + SEPARATOR
    _relayout_light()

func _relayout_light() -> void:
    var min_size = Vector2(0, 0)
    for _label in marquee._labels:
        var r = _label.get_rect()
        if r.size.x > min_size.x: min_size.x = r.size.x
        if r.size.y > min_size.y: min_size.y = r.size.y
    marquee.custom_minimum_size = min_size

func start():
    marquee._tween.start()

func stop():
    marquee._tween.stop()
