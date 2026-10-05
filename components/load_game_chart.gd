class_name LoadGameChart
extends StockChart

func _ready() -> void:
    super._ready()


func setup(netWorthHistory: Array) -> void:
    _historical_data = netWorthHistory
    super.draw()
