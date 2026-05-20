class_name HudStatus
extends HBoxContainer

const FRONT_LAYER = 10
const DEFAULT_LAYER = 1

@onready var CalendarDaysLabel: Label = %CalendarDaysLabel
@onready var MoneyLabel: Label = %MoneyLabel
@onready var icon_money: TextureRect = $IconMoney


func _ready():
    GameState.cash_changed.connect(update)


## Updates the UI with the current state
func update() -> void:
    CalendarDaysLabel.text = GameState.get_current_timestamp_humanized()
    MoneyLabel.text = Helpers.currencyify(GameState.cash)


## Sets the days label to an arbitrary value.
func set_days_arbitrary(text: String) -> void:
    CalendarDaysLabel.text = text


func hide_money_label() -> void:
    icon_money.visible = false
    MoneyLabel.visible = false


func show_money_label() -> void:
    icon_money.visible = true
    MoneyLabel.visible = true
