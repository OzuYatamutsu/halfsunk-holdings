class_name LoadGameItem
extends HBoxContainer

signal load_game(load_game_path: String)

@onready var LoadGameLabel: Label = %LoadGameLabel
@onready var LoadGameDayLabel: Label = %LoadGameDayLabel
@onready var LoadGameNetWorthLabel: Label = %LoadGameNetWorthLabel

@export var LoadGamePath: String

func setup(loadGamePath: String, label: String, day: String, netWorth: String) -> void:
    LoadGamePath = loadGamePath
    LoadGameLabel.text = label
    LoadGameDayLabel.text = day
    LoadGameNetWorthLabel.text = netWorth

func _on_load_game_button_pressed() -> void:
    load_game.emit(LoadGamePath)
