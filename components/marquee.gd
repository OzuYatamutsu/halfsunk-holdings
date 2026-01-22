class_name Marquee
extends Control

@export var text: String = ""
@export var interval_secs: float = 0.2

@onready var _label: Label = $Label
@onready var _scroll_interval_timer: Timer = $ScrollInterval

func start() -> void:
    _scroll_interval_timer.wait_time = interval_secs
    _label.text = text
    
func _scroll_step() -> void:
    pass  # TODO

func _on_scroll_interval_timeout() -> void:
    _scroll_step()
