class_name TickerTape
extends Control

const SEPARATOR: String = "   |   "
const STOCK_MARKET_DATA_BUFFER_MULT: int = 3
const MEASUREMENT_CHAR: String = "."

@export var speed_px_per_sec: float = 250.0

@onready var label: RichTextLabel = %Label
@onready var window_calibrator_label: RichTextLabel = %WindowCalibratorLabel

var _is_active: bool = false

var _window_size_char_count: int = 0
var _marquee_queue: Array[String] = []

var _up_regex := RegEx.new()
var _down_regex := RegEx.new()


func _ready() -> void:
    _up_regex.compile(r"(↗\s+[\d.]+)\s+\(([+][\d.]+%)\)")
    _down_regex.compile(r"(↘\s+[\d.]+)\s+\(([-][\d.]+%)\)")

    label.position = Vector2(0, label.position.y)


func start() -> void:
    _calibrate_window_size_characters()
    print("[ticker] max width is about " + str(_window_size_char_count) + " chars.")
    _populate_stock_market_data_queue()
    while label.text.length() < _window_size_char_count:
        label.text += _marquee_queue.pop_front() + SEPARATOR
    start_marquee()


## Set _window_size_char_count to the number of
## MEASUREMENT_CHARs which fit within get_viewport().size.x.
func _calibrate_window_size_characters() -> void:
    var char_width: float = window_calibrator_label.get_theme_font("normal_font").get_string_size(
        MEASUREMENT_CHAR,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        window_calibrator_label.get_theme_font_size("normal_font_size")
    ).x

    _window_size_char_count = int(
        get_viewport().size.x
        - window_calibrator_label.position.x / char_width
    )


func _populate_stock_market_data_queue() -> void:
    var stock_market_data = get_stock_market_data_formatted()
    for _i in range(STOCK_MARKET_DATA_BUFFER_MULT):
        _marquee_queue.append_array(stock_market_data)



func get_stock_market_data_formatted() -> Array[String]:
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

    return stock_market_data_text


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
    if _marquee_queue.is_empty():
        _populate_stock_market_data_queue()
    label.text += _marquee_queue.pop_front() + SEPARATOR
