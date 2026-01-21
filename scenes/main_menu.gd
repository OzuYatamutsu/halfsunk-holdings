extends Control

const _build_info_label_format = "Version {0}      | Build {1}"

@onready var BuildInfoLabel: Label = $MenuTitleCenter/LogoItems/BuildInfoLabel


func _ready() -> void:
    populate_version()

func populate_version() -> void:
    BuildInfoLabel.text = _build_info_label_format.format(
        GameState.VERSION_STRING, GameState.BUILD_DATE
    )
