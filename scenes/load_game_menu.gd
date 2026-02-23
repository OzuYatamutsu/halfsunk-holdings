extends Control

const SAVE_GAME_PATH_ROOT: String = "user://"
const SAVE_GAME_PATH_FOLDER: String = "savegames"
const SAVE_GAME_PATH: String = SAVE_GAME_PATH_ROOT + SAVE_GAME_PATH_FOLDER

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
    var save_game_dir = DirAccess.open(SAVE_GAME_PATH)
    if save_game_dir == null:
        print("Save game dir doesn't exist, creating")
        DirAccess.open(SAVE_GAME_PATH_ROOT).make_dir(SAVE_GAME_PATH_FOLDER)
        save_game_dir = DirAccess.open(SAVE_GAME_PATH)

    save_game_dir.list_dir_begin()
    var savefile = save_game_dir.get_next()

    while (savefile):
        savefile = SAVE_GAME_PATH + "/" + savefile

        if !_validate_savefile(savefile):
            savefile = save_game_dir.get_next()
            continue
    
        # Parse game data
        var saveData = _read_savefile(savefile)
        var saveGameItem = LoadGameItemScene.instantiate()
        LoadGamesContainer.add_child(saveGameItem)

        # Create item in the load games list
        saveGameItem.setup(savefile, saveData[0], saveData[1], saveData[2])
        saveGameItem.load_game.connect(_load_game)

        savefile = save_game_dir.get_next()
    save_game_dir.list_dir_end()

func _validate_savefile(savegame_file_path: String) -> bool:
    if !FileAccess.file_exists(savegame_file_path):
        return false

    # TODO fill this in after determining save file format
    return true

## Returns an array of the format: [Name, DayCount, Value]
func _read_savefile(savegame_file_path: String) -> Array[String]:
    # TODO fill this in after determining save file format
    return ["Autosave", "6", "$1,237,111.87"]

func _load_game(load_game_path: String):
    print("Loading saved game: " + load_game_path)
    pass  # TODO implement
