class_name StockChart
extends Control

const CHART_BG_COLOR: Color = Color("#000000")
const CHART_GRID_COLOR: Color = Color("#283442")
const CHART_TICK_COLOR: Color = Color("#283442")
const CHART_LINE_COLOR: Color = Color("#5c94c6")

@onready var _Chart: Chart = $_Chart

# This Chart will plot 3 different functions
var f1: Function

func _ready() -> void:
    # Let's create our @x values
    var x: PackedFloat32Array = ArrayOperations.multiply_float(range(-10, 11, 1), 0.5)

    # And our y values. It can be an n-size array of arrays.
    # NOTE: `x.size() == y.size()` or `x.size() == y[n].size()`
    var y: Array = ArrayOperations.multiply_int(ArrayOperations.cos(x), 20)
    
    # Let's customize the chart properties, which specify how the chart
    # should look, plus some additional elements like labels, the scale, etc...
    var cp: ChartProperties = _compose_chart_properties()
    cp.x_scale = 10
    cp.y_scale = 10

    # Now let's plot our data
    _Chart.plot([Function.new(
        x, y, "", _compose_function_style_params()
    )], cp)


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
    chart_properties.interactive = true

    return chart_properties


func _compose_function_style_params() -> Dictionary:
    return { 
        color = CHART_LINE_COLOR,
        #marker = Function.Marker.CIRCLE,
        type = Function.Type.LINE,
        #interpolation = Function.Interpolation.STAIR
    }
