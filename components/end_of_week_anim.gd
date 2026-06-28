extends PhaseTransitionAnim

var is_losing_state: bool

@onready var score_animator: AnimationPlayer = $ScoreAnimator

@onready var end_of_week_days_value: Label = %EndOfWeekDaysValue
@onready var investments_value: Label = %InvestmentsValue
@onready var cash_value: Label = %CashValue
@onready var net_worth_value: Label = %NetWorthValue
@onready var target_value: Label = %TargetValue
@onready var bonus_value: Label = %BonusValue
@onready var next_level_scene: String


func _ready() -> void:
    super._ready()
    next_level_scene = GameState.switch_page_data_bus
    _populate_data()

    is_losing_state = GameState.target > GameState.net_worth

    if (is_losing_state):
        _handle_losing_state()
    else:
        _handle_winning_state()


func _populate_data() -> void:
    end_of_week_days_value.text = str(GameState.day_count)
    investments_value.text = Helpers.currencyify(GameState.portfolio.value())
    cash_value.text = Helpers.currencyify(GameState.cash)
    net_worth_value.text = Helpers.currencyify(GameState.net_worth)
    target_value.text = Helpers.currencyify(GameState.target)
    bonus_value.text = Helpers.currencyify(GameState.net_worth - GameState.target)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
    # TODO test
    animation_complete.emit()


func _handle_losing_state() -> void:
    # TODO: play a losing animation
    var _gameOverModal: GameOverModal = load("res://components/GameOverModal.tscn").instantiate()
    add_child(_gameOverModal)


func _handle_winning_state() -> void:
    # TODO: play a winning animation
    pass  # TODO


func _on_continue_button_pressed() -> void:
    GameState.load_day(next_level_scene)
