class_name HudStatus
extends HBoxContainer

@onready var CalendarDaysLabel: Label = %CalendarDaysLabel
@onready var MoneyLabel: Label = %MoneyLabel
@onready var IconMoney: TextureRect = $IconMoney


func _ready():
    GameState.cash_changed.connect(update)


## Updates the UI with the current state
func update() -> void:
    if (GameState.is_in_phase_transition):
        return
    CalendarDaysLabel.text = GameState.get_current_timestamp_humanized()
    MoneyLabel.text = Helpers.currencyify(GameState.cash)


## Sets the days label to an arbitrary value.
func set_days_arbitrary(text: String) -> void:
    CalendarDaysLabel.text = text


func hide_money_label() -> void:
    IconMoney.visible = false
    MoneyLabel.visible = false


func show_money_label() -> void:
    IconMoney.visible = true
    MoneyLabel.visible = true
