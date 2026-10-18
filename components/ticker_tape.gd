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
var _message_char_lengths: Array[int] = []
var _message_widths: Array[float] = []
var _scroll_offset: float = 0.0

var _up_regex := RegEx.new()
var _down_regex := RegEx.new()
var _bbcode_regex := RegEx.new()


func _ready() -> void:
    _up_regex.compile(r"(↗\s+[\d.]+)\s+\(([+][\d.]+%)\)")
    _down_regex.compile(r"(↘\s+[\d.]+)\s+\(([-][\d.]+%)\)")
    _bbcode_regex.compile(r"\[/?[a-zA-Z][^\]]*\]")

    label.position = Vector2(0, label.position.y)


func _process(delta: float) -> void:
    if !_is_active:
        return

    _scroll_ticker(delta)
    _remove_offscreen_messages()
    _append_from_queue()


func start() -> void:
    _calibrate_window_size_characters()
    print("[ticker] max width is about " + str(_window_size_char_count) + " chars.")
    _populate_stock_market_data_queue()
    _append_from_queue()
    _is_active = true


func stop() -> void:
    _is_active = false


## Flush the marquee queue and replace it with fresh data
## from live stock market prices.
func refresh_stock_market_data() -> void:
    print("[ticker] refreshing stock market data")
    _marquee_queue = []
    _populate_stock_market_data_queue()


## Places the text to be fired at the beginning of the
## scroll queue.
func fire_text(text: String, is_bold=true) -> void:
    _marquee_queue = []
    if is_bold:
        _marquee_queue.append("[b]" + text + "[/b]")
    else:
        _marquee_queue.append(text)
    refresh_stock_market_data()


func _append_from_queue() -> void:
    if _marquee_queue.is_empty():
        _populate_stock_market_data_queue()
    if _marquee_queue.is_empty():
        return

    var visible_content_width: float = 0.0

    for width in _message_widths:
        visible_content_width += width

    while visible_content_width - _scroll_offset < get_viewport_rect().size.x:
        var text_to_add: String = _marquee_queue.pop_front() + SEPARATOR
        var text_width: float = _get_effective_text_width(text_to_add)

        _message_char_lengths.append(len(text_to_add))
        _message_widths.append(text_width)
        label.text += text_to_add

        visible_content_width += text_width


## Returns the text width of the rendered text,
## ignoring bbcode-related chars
func _get_effective_text_width(text: String) -> float:
    return window_calibrator_label.get_theme_font("normal_font").get_string_size(
        _bbcode_regex.sub(text, "", true),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        window_calibrator_label.get_theme_font_size("normal_font_size")
    ).x


func _scroll_ticker(delta: float) -> void:
    _scroll_offset += speed_px_per_sec * delta
    label.position.x = -_scroll_offset


func _remove_offscreen_messages() -> void:
    while not _message_widths.is_empty() and _scroll_offset >= _message_widths[0]:
        _scroll_offset -= _message_widths.pop_front()
        label.text = label.text.substr(_message_char_lengths.pop_front())


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
        (get_viewport().size.x - window_calibrator_label.position.x)
        / char_width
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
