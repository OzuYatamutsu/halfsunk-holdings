class_name Level
extends Control

var _events: Dictionary[int, Callable] = {}

@onready var window: GameWindow = %GameWindow

func _ready() -> void:
    AudioEngine.play_bgm(AudioEngine.BGM_GAME)
    GameState.clear_state()
    GameState.start_day()
    window.browser.load_page("res://pages/StartPage.tscn")
