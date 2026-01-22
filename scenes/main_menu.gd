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
    pass # Replace with function body.

func _on_load_game_button_pressed() -> void:
    pass # Replace with function body.

func _on_settings_button_pressed() -> void:
    pass # Replace with function body.

func _on_quit_button_pressed() -> void:
    get_tree().quit()
