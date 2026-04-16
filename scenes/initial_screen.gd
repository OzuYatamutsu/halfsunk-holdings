extends Control

## Initial loading screen, do loading here and then
## transition to main menu

func _ready() -> void:
    do_load()

    AudioEngine.play_bgm(AudioEngine.BGM_MAINMENU)
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func do_load() -> void:
    print("starting preload")

    AudioEngine.adjust_master_volume(AudioEngine.INITIAL_MASTER_VOLUME)
    AudioEngine.adjust_music_volume(AudioEngine.INITIAL_MUSIC_VOLUME)
    AudioEngine.adjust_sfx_volume(AudioEngine.INITIAL_SFX_VOLUME)

    print("audio: loading bgm")
    AudioEngine.load_bgm()
    
    print("audio: loading sfx")
    AudioEngine.load_sfx()
    
    print("preload complete")
