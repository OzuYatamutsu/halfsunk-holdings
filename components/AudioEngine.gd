# class_name AudioEngine
extends Node

const INITIAL_MASTER_VOLUME: float = 1.0
const INITIAL_MUSIC_VOLUME: float = 0.75
const INITIAL_SFX_VOLUME: float = 1.0
const DUCK_SFX_PERCENT: float = 0.4

var BGM_MAINMENU: AudioStreamMP3
var BGM_GAME: AudioStreamMP3
var SFX_CLICK: AudioStreamMP3
var SFX_BUYSELL: AudioStreamMP3
var SFX_MESSAGE_RECEIVED: AudioStreamMP3
var SFX_MESSAGE_SENT: AudioStreamMP3
var SFX_WATCH_BEEP: AudioStreamMP3
var SFX_UPDATE: AudioStreamMP3

var _bgm_duck_active: bool = false
var _bgm_duck_previous_volume: float

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

    sfx.finished.connect(_on_sfx_finished)


func load_bgm() -> void:
    BGM_MAINMENU = AudioStreamMP3.load_from_file("res://bgm/bgm_main_menu.mp3")
    BGM_GAME = AudioStreamMP3.load_from_file("res://bgm/bgm1.mp3")


func load_sfx() -> void:
    SFX_CLICK = AudioStreamMP3.load_from_file("res://sfx/sfx_click.mp3")
    SFX_BUYSELL = AudioStreamMP3.load_from_file("res://sfx/sfx_cha_ching.mp3")
    SFX_MESSAGE_RECEIVED = AudioStreamMP3.load_from_file("res://sfx/sfx_chat_message_received.mp3")
    SFX_MESSAGE_SENT = AudioStreamMP3.load_from_file("res://sfx/sfx_chat_message_sent.mp3")
    SFX_WATCH_BEEP = AudioStreamMP3.load_from_file("res://sfx/sfx_watch_beep.mp3")
    SFX_UPDATE = AudioStreamMP3.load_from_file("res://sfx/sfx_update.mp3")
    

func play_sfx(_sfx: AudioStreamMP3) -> void:
    _duck_bgm()

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


## Temporarily reduce BGM volume during SFX
func _duck_bgm() -> void:
    if _bgm_duck_active:
        return
    _bgm_duck_active = true

    var bus = AudioServer.get_bus_index("bgm")
    _bgm_duck_previous_volume = get_music_volume()

    create_tween().tween_method(
        func(v): AudioServer.set_bus_volume_db(bus, linear_to_db(v)),
        _bgm_duck_previous_volume,
        _bgm_duck_previous_volume * DUCK_SFX_PERCENT,
        0.1
    )


## Restore BGM volume after sfx finished
func _on_sfx_finished() -> void:
    if not _bgm_duck_active:
        return
    _bgm_duck_active = false

    var bus = AudioServer.get_bus_index("bgm")

    create_tween().tween_method(
        func(v): AudioServer.set_bus_volume_db(bus, linear_to_db(v)),
        get_music_volume(),
        _bgm_duck_previous_volume,
        0.2
    )
