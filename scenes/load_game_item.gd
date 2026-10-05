class_name LoadGameItem
extends HBoxContainer

signal load_game(load_game_path: String)

@onready var LoadGameLabel: Label = %LoadGameLabel
@onready var LoadGameDayLabel: Label = %LoadGameDayLabel
@onready var LoadGameNetWorthLabel: Label = %LoadGameNetWorthLabel
@onready var NetWorthChart: LoadGameChart = %NetWorthChart

@export var LoadGamePath: String

func setup(loadGamePath: String, saveGameName: String, 
           dayCount: String, dayOfWeek: String,
           totalScore: String, netWorthHistory: Array) -> void:
    LoadGamePath = loadGamePath
    LoadGameLabel.text = saveGameName
    LoadGameDayLabel.text = "%s, day %s" % [dayOfWeek, dayCount]
    LoadGameNetWorthLabel.text = totalScore
    NetWorthChart.setup(netWorthHistory)


func _on_load_game_button_pressed() -> void:
    load_game.emit(LoadGamePath)
