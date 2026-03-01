extends Control

const _build_info_label_format = "Version {version}      | Build {build}"

@onready var BuildInfoLabel: Label = $MenuTitleCenter/LogoItems/BuildInfoLabel


func _ready() -> void:
    populate_version()

func populate_version() -> void:
    BuildInfoLabel.text = _build_info_label_format.format({
        "version": GameState.VERSION_STRING,
        "build": GameState.BUILD_DATE
    })

func _on_new_game_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_CLICK)
    get_tree().change_scene_to_file("res://levels/Level0.tscn")

func _on_load_game_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_CLICK)
    get_tree().change_scene_to_file("res://scenes/LoadGameMenu.tscn")

func _on_settings_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_CLICK)
    get_tree().change_scene_to_file("res://scenes/SettingsMenu.tscn")

func _on_quit_button_pressed() -> void:
    AudioEngine.play_sfx(AudioEngine.SFX_CLICK)
    get_tree().quit()
