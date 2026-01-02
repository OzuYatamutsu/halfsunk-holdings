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
