extends PhaseTransitionAnim

var is_losing_state: bool

@onready var score_animator: AnimationPlayer = $ScoreAnimator

@onready var end_of_week_days_value: Label = %EndOfWeekDaysValue
@onready var investments_value: Label = %InvestmentsValue
@onready var cash_value: Label = %CashValue
@onready var net_worth_value: Label = %NetWorthValue
@onready var target_value: Label = %TargetValue
@onready var bonus_value: Label = %BonusValue


func _ready() -> void:
    super._ready()
    is_losing_state = GameState.target > GameState.net_worth

    if (is_losing_state):
        _handle_losing_state()
    else:
        _handle_winning_state()


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
    pass # Replace with function body.
