class_name GameOverModal
extends Modal

@onready var total_score_value: Label = %TotalScoreValue
@onready var job_held_for_value: Label = %JobHeldForValue


func _ready() -> void:
    total_score_value.text = Helpers.currencyify(GameState.total_score, false, false)
    job_held_for_value.text = "%s days" % [GameState.day_count]
