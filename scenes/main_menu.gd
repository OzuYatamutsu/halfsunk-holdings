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
