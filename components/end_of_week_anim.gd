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
    # TODO: show total score, buttons to restart the week or quit
    pass  # TODO

func _handle_winning_state() -> void:
    # TODO: zero out all investments
    # TODO: start next week
    pass  # TODO
