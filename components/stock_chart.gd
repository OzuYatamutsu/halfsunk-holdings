class_name StockChart
extends MarginContainer

## A stock chart representing historical data.
## The x axis is timestamp, and the y axis is price.

const CHART_BG_COLOR: Color = Color("#000000")
const CHART_GRID_COLOR: Color = Color("#283442")
const CHART_TICK_COLOR: Color = Color("#283442")
const CHART_LINE_COLOR: Color = Color("#5c94c6")

@onready var _Chart: Chart = $_Chart
@onready var _placeholder_image: TextureRect = $_PLACEHOLDER_PREVIEW

var _chart_func: Function

## An array of tuples of the form: [timestamp, value];
## i.e., the format of Stock.last_values.
var _historical_data: Array[Array]

func _ready() -> void:
    _placeholder_image.queue_free()

func update_stock(stock: Stock) -> void:
    _historical_data = stock.last_values

## Call this to draw the graph after calling set_stock().
func draw() -> void:
    var x_vals: Array[int]
    var y_vals: Array[float]
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
    chart_properties.show_x_label = true
    chart_properties.draw_vertical_grid = false
    chart_properties.show_tick_labels = false
    chart_properties.y_label = "Price"
    chart_properties.x_label = "Time"
    return chart_properties


func _compose_function_style_params() -> Dictionary:
    return { 
        color = CHART_LINE_COLOR,
        #marker = Function.Marker.CIRCLE,
        type = Function.Type.LINE,
        #interpolation = Function.Interpolation.STAIR
    }
