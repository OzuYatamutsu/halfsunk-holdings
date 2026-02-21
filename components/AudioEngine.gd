# class_name AudioEngine
extends Node

@onready var bgm: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var sfx: AudioStreamPlayer = AudioStreamPlayer.new()
var _bgm_position: float = 0.0

func _ready() -> void:
    add_child(bgm)
    add_child(sfx)
    
    bgm.bus = "bgm"
    sfx.bus = "sfx"
    
    bgm.autoplay = false
    sfx.autoplay = false

func play_sfx(_sfx: AudioStreamMP3) -> void:
    _sfx.loop = false
    sfx.stream = _sfx
    sfx.play()

func play_bgm(_bgm: AudioStreamMP3) -> void:
    _bgm.loop = true
    bgm.stream = _bgm
    bgm.play()

func pause_bgm() -> void:
    _bgm_position = bgm.get_playback_position()
    bgm.stop()

func resume_bgm() -> void:
    bgm.play(_bgm_position)

## value should be between 0.0 and 1.0
func adjust_master_volume(value: float) -> void:
    print("audio: adjusted master volume to " + str(value))
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index("Master"),
        linear_to_db(value)
    )

func adjust_music_volume(value: float) -> void:
    print("audio: adjusted music volume to " + str(value))
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index("bgm"),
        linear_to_db(value)
    )

func adjust_sfx_volume(value: float) -> void:
    print("audio: adjusted sfx volume to " + str(value))
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index("sfx"),
        linear_to_db(value)
    )
