class_name HudStatus
extends HBoxContainer

@onready var CalendarDaysLabel: Label = %CalendarDaysLabel
@onready var MoneyLabel: Label = %MoneyLabel


func _ready():
    GameState.cash_changed.connect(update)


## Updates the UI with the current state
func update() -> void:
    CalendarDaysLabel.text = str(GameState.day_count)
    MoneyLabel.text = Helpers.currencyify(GameState.cash)
