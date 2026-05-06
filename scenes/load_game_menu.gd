extends Control

@onready var LoadGamesContainer: VBoxContainer = %LoadGamesContainer
@onready var TestLoadGameItem: HBoxContainer = %_test_load_game

var LoadGameItemScene: Resource = preload("res://scenes/LoadGameItem.tscn")


func _ready() -> void:
    # Remove test item
    TestLoadGameItem.queue_free()
    
    load_saved_games()

func _on_main_menu_return_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func load_saved_games() -> void:
    var save_game_dir = DirAccess.open(GameState.SAVE_GAME_PATH)
    save_game_dir.list_dir_begin()
    var savefile = save_game_dir.get_next()

    while (savefile):
        savefile = GameState.SAVE_GAME_PATH + "/" + savefile

        if !_validate_savefile(savefile):
            savefile = save_game_dir.get_next()
            continue
    
        # Parse game data
        var saveDataHeader = _read_savefile_header(savefile)
        var saveGameItem = LoadGameItemScene.instantiate()
        LoadGamesContainer.add_child(saveGameItem)

        # Create item in the load games list
        saveGameItem.setup(savefile, saveDataHeader[0], saveDataHeader[1], saveDataHeader[2])
        saveGameItem.load_game.connect(_load_game)

        savefile = save_game_dir.get_next()
    save_game_dir.list_dir_end()


func _validate_savefile(savegame_file_path: String) -> bool:
    if !FileAccess.file_exists(savegame_file_path):
        return false

    # TODO fill this in after determining save file format
    return true


## Returns an array of the format: [name of savefile, day count, day of week, total_score]
func _read_savefile_header(savegame_file_path: String) -> Array[String]:
    # TODO
    return ["Autosave", "6", "Monday", "$1,237,111.87"]


func _load_game(load_game_path: String):
    print("Loading saved game: " + load_game_path)
    pass  # TODO implement
