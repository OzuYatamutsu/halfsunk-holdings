class_name TickerTape
extends Control

@export var speed_px_per_sec: float = 100.0

@onready var label: Label = %Label

func set_text(text: String) -> void:
    label.text = text


func start_marquee() -> void:
    # Wait one frame so sizes are correct
    await get_tree().process_frame

    var tween = create_tween()
    var y := label.position.y
    
    # Start just off the right side
    label.position = Vector2(
        get_viewport_rect().size.x,
        label.position.y
    )

    # Move label from right to left
    tween.tween_property(
        label,
        "position:x",
        -label.size.x,
        ((get_viewport_rect().size.x + label.size.x) / speed_px_per_sec)
    ).set_trans(Tween.TRANS_LINEAR)
