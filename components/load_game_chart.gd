class_name LoadGameChart
extends StockChart

func _ready() -> void:
    super._ready()


func setup(netWorthHistory: Array) -> void:
    _historical_data = netWorthHistory
    super.draw()


func _compose_chart_properties() -> ChartProperties:
    var cp = super._compose_chart_properties()
    cp.y_label = "Net Worth"
    return cp
