class_name GameOverModal
extends Modal

@onready var total_score_value: Label = %TotalScoreValue
@onready var job_held_for_value: Label = %JobHeldForValue


func _ready() -> void:
    total_score_value.text = Helpers.currencyify(GameState.total_score, false, false)
    job_held_for_value.text = "%s days" % [GameState.day_count - 1]


func _on_main_menu_button_pressed() -> void:
    print("return to main menu button pressed")
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_quit_button_pressed() -> void:
    print("quit button pressed")
    get_tree().quit()
