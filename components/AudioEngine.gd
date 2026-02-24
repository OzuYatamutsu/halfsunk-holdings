# class_name AudioEngine
extends Node

const INITIAL_MASTER_VOLUME: float = 1.0
const INITIAL_MUSIC_VOLUME: float = 0.75
const INITIAL_SFX_VOLUME: float = 1.0

var BGM_MAINMENU: AudioStreamMP3
var BGM_GAME: AudioStreamMP3
var SFX_CLICK: AudioStreamMP3

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

func load_bgm() -> void:
    BGM_MAINMENU = AudioStreamMP3.load_from_file("res://bgm/bgm_main_menu.mp3")
    BGM_GAME = AudioStreamMP3.load_from_file("res://bgm/bgm1.mp3")

func load_sfx() -> void:
    SFX_CLICK = AudioStreamMP3.load_from_file("res://sfx/sfx_click.mp3")

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

func get_master_volume() -> float:
    return AudioServer.get_bus_volume_linear(
        AudioServer.get_bus_index("Master")
    )

func get_music_volume() -> float:
    return AudioServer.get_bus_volume_linear(
        AudioServer.get_bus_index("bgm")
    )

func get_sfx_volume() -> float:
    return AudioServer.get_bus_volume_linear(
        AudioServer.get_bus_index("sfx")
    )

## value should be between 0.0 and 1.0
func adjust_master_volume(value: float) -> void:
    print("audio: adjusted master volume to " + str(value))
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index("Master"),
        linear_to_db(value)
    )

## value should be between 0.0 and 1.0
func adjust_music_volume(value: float) -> void:
    print("audio: adjusted music volume to " + str(value))
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index("bgm"),
        linear_to_db(value)
    )

## value should be between 0.0 and 1.0
func adjust_sfx_volume(value: float) -> void:
    print("audio: adjusted sfx volume to " + str(value))
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index("sfx"),
        linear_to_db(value)
    )
