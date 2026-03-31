class_name HudStatus
extends HBoxContainer

@onready var CalendarDaysLabel: Label = %CalendarDaysLabel
@onready var MoneyLabel: Label = %MoneyLabel


## Updates the UI with the current state
func update() -> void:
    CalendarDaysLabel.text = str(GameState.day_count)
    MoneyLabel.text = "%.2f" % GameState.cash
