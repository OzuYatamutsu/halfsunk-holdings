class_name TickerTape
extends Control

@export var speed_px_per_sec: float = 250.0

@onready var label: Label = %Label

var _tween = create_tween()
var _is_active: bool = false
var _marquee_queue: Array[String] = []


func _ready() -> void:
    _tween.finished.connect(_on_marquee_finished)


func queue_text(text: String) -> void:
    _marquee_queue.append(text)
    if (!_is_active):
        set_text(_marquee_queue.pop_front())
        start_marquee()


func set_text(text: String) -> void:
    label.text = text


func start_marquee() -> void:    
    _is_active = true

    var y := label.position.y
    
    # Start just off the right side
    label.position = Vector2(
        get_viewport_rect().size.x,
        label.position.y
    )

    # Move label from right to left
    _tween.tween_property(
        label,
        "position:x",
        -label.size.x,
        ((get_viewport_rect().size.x + label.size.x) / speed_px_per_sec)
    ).set_trans(Tween.TRANS_LINEAR)


func _on_marquee_finished() -> void:
    if (!_marquee_queue.is_empty()):
        set_text(_marquee_queue.pop_front())
        start_marquee()
    else:
        _is_active = false
