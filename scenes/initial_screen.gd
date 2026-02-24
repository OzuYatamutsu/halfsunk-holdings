extends Node2D

## Initial loading screen, do loading here and then
## transition to main menu

func _ready() -> void:
    do_load()
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func do_load() -> void:
    GameState.clear_state()

    AudioEngine.adjust_master_volume(AudioEngine.INITIAL_MASTER_VOLUME)
    AudioEngine.adjust_music_volume(AudioEngine.INITIAL_MUSIC_VOLUME)
    AudioEngine.adjust_sfx_volume(AudioEngine.INITIAL_SFX_VOLUME)

    AudioEngine.play_bgm(
        AudioStreamMP3.load_from_file("res://bgm/bgm_main_menu.mp3")
    )
