class_name Marquee
extends Control

@export var text: String = "CAT 223.25 ↗ 22.05 (+10.96%)  |   BIRD 415.28 ↗ 22.05 (+5.61%)  |   DOG 15.26 ↘ 1.06 (−6.50%)    |   LZRD 225.14 ↗ 15.45 (+7.37%)    |    "
@export var interval_secs: float = 10.0

@onready var _label: Label = $Label
@onready var _label2: Label = $Label2

## Simulates infinite scrolling text using two
## repeated labels which loop back on top of
## each other when it gets to the edge of the
## screen.

var _tween: Tween
var _tween2: Tween

func _ready() -> void:
    _label.text = text
    _label2.text = text
    _tween = create_tween().set_loops()
    _tween2 = create_tween().set_loops()

    _tween.tween_property(
        _label, "position:x", -_label.size.x, interval_secs
    ).from(_label.position.x)

    _tween2.tween_property(
        _label2, "position:x", _label.position.x, interval_secs
    ).from(_label2.position.x)
