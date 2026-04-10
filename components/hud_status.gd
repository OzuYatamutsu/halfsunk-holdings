class_name HudStatus
extends HBoxContainer

@onready var CalendarDaysLabel: Label = %CalendarDaysLabel
@onready var MoneyLabel: Label = %MoneyLabel


func _ready():
    GameState.cash_changed.connect(update)
    GameState.delayed_tick.connect(update)


## Updates the UI with the current state
func update() -> void:
    CalendarDaysLabel.text = GameState.get_current_timestamp_humanized()
    MoneyLabel.text = Helpers.currencyify(GameState.cash)
