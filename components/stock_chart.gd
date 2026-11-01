class_name StockChart
extends MarginContainer

## A stock chart representing historical data.
## The x axis is timestamp, and the y axis is price.

const CHART_BG_COLOR: Color = Color("#000000")
const CHART_GRID_COLOR: Color = Color("#283442")
const CHART_TICK_COLOR: Color = Color("#283442")
const CHART_LINE_COLOR: Color = Color("#5c94c6")
const MAX_DUMMY_MODE_POINTS: int = 7
const DUMMY_MODE_RANDRANGE: Array = [0, 100]
const DUMMY_MODE_DELAY_COUNT: int = 100

@onready var _Chart: Chart = $_Chart
@onready var _placeholder_image: TextureRect = $_PLACEHOLDER_PREVIEW
@export var _is_dummy_mode: bool = true

var _dummy_mode_delay_counter: int = 0
var _chart_func: Function

## An array of tuples of the form: [timestamp, value];
## i.e., the format of Stock.last_values.
var _historical_data: Array

func _ready() -> void:
    _placeholder_image.queue_free()


func _process(_delta: float) -> void:
    if !_is_dummy_mode:
        return
    if len(_historical_data) > 2 and _dummy_mode_delay_counter <= DUMMY_MODE_DELAY_COUNT:
        _dummy_mode_delay_counter += 1
        return
    _draw_dummy_chart()
    _dummy_mode_delay_counter = 0


func _draw_dummy_chart() -> void:
    print("drawing dummy chart!")
    _historical_data = []

    for i in range(MAX_DUMMY_MODE_POINTS):
        _historical_data.append([
            i, randf_range(
                DUMMY_MODE_RANDRANGE[0],
                DUMMY_MODE_RANDRANGE[1]
            )
        ])
    _Chart.queue_redraw()
    draw()


func update_stock(stock: Stock) -> void:
    _historical_data = stock.last_values
    _is_dummy_mode = len(_historical_data) < 2


## Call this to draw the graph after calling set_stock().
func draw() -> void:
    var x_vals: Array[int] = []
    var y_vals: Array[float] = []
    var cp: ChartProperties = _compose_chart_properties()

    for _xy_pair in _historical_data:
        x_vals.append(_xy_pair[0])
        y_vals.append(_xy_pair[1])

    _chart_func = Function.new(
        x_vals, y_vals, "", _compose_function_style_params()
    )
    _Chart.plot([_chart_func], cp)


## Pass in a tuple of the form: [timestamp, value].
func add_point(last_value_record: Array[Variant]) -> void:
    assert(_chart_func != null)
    _chart_func.add_point(last_value_record[0], last_value_record[1])
    _Chart.queue_redraw()

## After composing chart properties, other things to modify:
## .title, .x_label, .y_label, .x_scale, .y_scale
func _compose_chart_properties() -> ChartProperties:
    var chart_properties: ChartProperties = ChartProperties.new()
    chart_properties.colors.frame = CHART_BG_COLOR
    chart_properties.colors.background = Color.TRANSPARENT
    chart_properties.colors.grid = CHART_GRID_COLOR
    chart_properties.colors.ticks = CHART_TICK_COLOR
    chart_properties.colors.text = Color.WHITE_SMOKE
    chart_properties.draw_bounding_box = false
    chart_properties.interactive = false
    chart_properties.x_scale = 5
    chart_properties.y_scale = 5
    chart_properties.draw_ticks = false
    chart_properties.draw_grid_box = true
    chart_properties.show_x_label = false
    chart_properties.show_y_label = true
    chart_properties.show_title = false
    chart_properties.draw_vertical_grid = false
    chart_properties.show_tick_labels = false
    chart_properties.y_label = "Price" if not _is_dummy_mode else ""
    chart_properties.x_label = "Time" if not _is_dummy_mode else ""
    chart_properties.title = "Awaiting data..." if _is_dummy_mode else ""
    chart_properties.show_title = _is_dummy_mode
    return chart_properties


func _compose_function_style_params() -> Dictionary:
    return {
        color = CHART_LINE_COLOR,
        #marker = Function.Marker.CIRCLE,
        type = Function.Type.LINE,
        #interpolation = Function.Interpolation.STAIR
    }
