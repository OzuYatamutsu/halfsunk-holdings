class_name Level
extends Control

var _events: Dictionary[int, Callable] = {}

@onready var window: GameWindow = $GameWindow

func _ready() -> void:
    AudioEngine.play_bgm(AudioEngine.BGM_GAME)
    GameState.clear_state()
    GameState.start_day()
    GameState.tick.connect(_on_tick)
    window.browser.load_page("res://pages/StartPage.tscn")

func _on_tick() -> void:
    if GameState.tick_count in _events:
        print(
            "event: firing %s" % [
                _events[GameState.tick_count].get_method()
            ]
        )
        _events[GameState.tick_count].call()
