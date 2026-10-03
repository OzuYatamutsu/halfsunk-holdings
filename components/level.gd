class_name Level
extends Control

@onready var window: GameWindow = %GameWindow

func _ready() -> void:
    AudioEngine.play_bgm(AudioEngine.BGM.BGM1)
    GameState.clear_state()
    GameState.start_day()
    window.browser.load_page("res://pages/StartPage.tscn")
