class_name TickerTape
extends Control

@export var speed_px_per_sec: float = 250.0

@onready var label: RichTextLabel = %Label

var _is_active: bool = false
var _marquee_queue: Array[String] = []
var _up_regex := RegEx.new()
var _down_regex := RegEx.new()
    

func _ready() -> void:
    _up_regex.compile(r"(↗\s+[\d.]+)\s+\(([+][\d.]+%)\)")
    _down_regex.compile(r"(↘\s+[\d.]+)\s+\(([−-][\d.]+%)\)")

    label.position = Vector2(
        get_viewport_rect().size.x,
        label.position.y
    )


func queue_text(text: String) -> void:
    if (!_marquee_queue.has(text)):
        _marquee_queue.append(text)
    if (!_is_active):
        set_text(_marquee_queue.pop_front())
        start_marquee()


func flush_and_fire_text(text: String) -> void:
    _marquee_queue.clear()
    set_text(text)
    if !_is_active:
        start_marquee()


func set_text(text: String) -> void:
    label.text = text


func queue_text_from_stock_market_data() -> void:
    var stock_market_data_text: Array[String] = GameState.stock_market.get_all_to_string()

    for i in stock_market_data_text.size():
        stock_market_data_text[i] = _up_regex.sub(
            stock_market_data_text[i],
            "[color=green]$1[/color] ([color=green]$2[/color])",
            true
        )

        stock_market_data_text[i] = _down_regex.sub(
            stock_market_data_text[i],
            "[color=red]$1[/color] ([color=red]$2[/color])",
            true
        )

    queue_text(
        "    |   ".join(stock_market_data_text)
    )


func start_marquee() -> void:    
    _is_active = true

    var _tween = create_tween()
    
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

    _tween.finished.connect(_on_marquee_finished)


func _on_marquee_finished() -> void:
    if (!_marquee_queue.is_empty()):
        set_text(_marquee_queue.pop_front())
        start_marquee()
    else:
        _is_active = false
