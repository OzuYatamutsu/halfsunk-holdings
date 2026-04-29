extends PhaseTransitionAnim

var is_losing_state: bool


func _ready() -> void:
    is_losing_state = GameState.target >= GameState.net_worth
    
    if (is_losing_state):
        _handle_losing_state()
    else:
        _handle_winning_state()


func _handle_losing_state() -> void:
    # TODO: play a losing animation
    var _gameOverModal: GameOverModal = load("res://components/GameOverModal.tscn").instantiate()
    add_child(_gameOverModal)

func _handle_winning_state() -> void:
    # TODO: play a winning animation
    pass  # TODO
