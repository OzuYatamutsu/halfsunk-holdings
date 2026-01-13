extends Node2D

## Initial loading screen, do loading here and then
## transition to main menu

func _ready() -> void:
    do_load()
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func do_load() -> void:
    GameState.clear_state()
