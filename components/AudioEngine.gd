# class_name AudioEngine
extends Node

const INITIAL_MASTER_VOLUME: float = 1.0
const INITIAL_MUSIC_VOLUME: float = 0.75
const INITIAL_SFX_VOLUME: float = 1.0
const DUCK_SFX_PERCENT: float = 0.8
const DUCK_SFX_DURATION_SECS: float = 0.05

enum BGM {
    NONE,
    BGM_MAINMENU,
    BGM1
}
enum BGM_COMPONENTS {
    INTRO,
    LOOP,
    OUTTRO
}
var BGM_COMPONENTS_MAP = {}
var _current_bgm: BGM = BGM.BGM1
var _bgm_pointer: int = 0

var BGM_MAINMENU: AudioStreamMP3
var BGM_1_INTRO: AudioStreamMP3
var BGM_1_OUTTRO: AudioStreamMP3
var BGM_1_LOOP_01: AudioStreamMP3
var BGM_1_LOOP_02: AudioStreamMP3
var BGM_1_LOOP_03: AudioStreamMP3
var BGM_1_LOOP_04: AudioStreamMP3
var BGM_1_LOOP_05: AudioStreamMP3
var BGM_1_LOOP_06: AudioStreamMP3
var BGM_1_LOOP_07: AudioStreamMP3
var BGM_1_LOOP_08: AudioStreamMP3
var BGM_1_LOOP_09: AudioStreamMP3
var BGM_1_LOOP_10: AudioStreamMP3
var BGM_1_LOOP_11: AudioStreamMP3
var BGM_1_LOOP_12: AudioStreamMP3
var BGM_1_LOOP_13: AudioStreamMP3
var BGM_1_LOOP_14: AudioStreamMP3

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

    bgm.finished.connect(_bgm_continue_loop)
    sfx.finished.connect(_on_sfx_finished)


func load_bgm() -> void:
    BGM_MAINMENU = AudioStreamMP3.load_from_file("res://bgm/bgm_main_menu.mp3")
    BGM_1_INTRO = AudioStreamMP3.load_from_file("res://bgm/bgm-intro.mp3")
    BGM_1_OUTTRO = AudioStreamMP3.load_from_file("res://bgm/bgm-outtro.mp3")
    BGM_1_LOOP_01 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section01.mp3")
    BGM_1_LOOP_02 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section02.mp3")
    BGM_1_LOOP_03 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section03.mp3")
    BGM_1_LOOP_04 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section04.mp3")
    BGM_1_LOOP_05 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section05.mp3")
    BGM_1_LOOP_06 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section06.mp3")
    BGM_1_LOOP_07 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section07.mp3")
    BGM_1_LOOP_08 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section08.mp3")
    BGM_1_LOOP_09 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section09.mp3")
    BGM_1_LOOP_10 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section10.mp3")
    BGM_1_LOOP_11 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section11.mp3")
    BGM_1_LOOP_12 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section12.mp3")
    BGM_1_LOOP_13 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section13.mp3")
    BGM_1_LOOP_14 = AudioStreamMP3.load_from_file("res://bgm/bgm-loop-section14.mp3")
    BGM_COMPONENTS_MAP = {
        BGM.BGM_MAINMENU: {
            BGM_COMPONENTS.INTRO: null,
            BGM_COMPONENTS.LOOP: [BGM_MAINMENU],
            BGM_COMPONENTS.OUTTRO: null
        },
        BGM.BGM1: {
            BGM_COMPONENTS.INTRO: BGM_1_INTRO,
            BGM_COMPONENTS.LOOP: [
                BGM_1_LOOP_01, BGM_1_LOOP_02, BGM_1_LOOP_03,
                BGM_1_LOOP_04, BGM_1_LOOP_05, BGM_1_LOOP_06,
                BGM_1_LOOP_07, BGM_1_LOOP_08, BGM_1_LOOP_09,
                BGM_1_LOOP_10, BGM_1_LOOP_11, BGM_1_LOOP_12,
                BGM_1_LOOP_13, BGM_1_LOOP_14
            ],
            BGM_COMPONENTS.OUTTRO: BGM_1_OUTTRO
        }
    }


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


func play_bgm(_bgm: BGM) -> void:
    _current_bgm = _bgm
    _bgm_pointer = 0
    
    if BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.INTRO]:
        bgm.stream = BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.INTRO]
    else:
        bgm.stream = BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.LOOP][_bgm_pointer]

    bgm.play()


func end_bgm() -> void:
    if not _current_bgm or _current_bgm == BGM.NONE:
        return

    print("[bgm] queueing outtro")
    _bgm_pointer = -1


func pause_bgm() -> void:
    _bgm_position = bgm.get_playback_position()
    bgm.stop()


func resume_bgm() -> void:
    bgm.play(_bgm_position)


func _bgm_continue_loop() -> void:
    if not _current_bgm or _current_bgm == BGM.NONE:
        bgm.stop()
        return

    if _bgm_pointer == -1:
        print("[bgm] playing outtro")

        if not BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.OUTTRO]:
            _current_bgm = BGM.NONE
            bgm.stop()
            return

        bgm.stream = BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.OUTTRO]
        _current_bgm = BGM.NONE
        bgm.play()
        return
    
    print("[bgm] playing section " + str(_bgm_pointer))
    bgm.stream = BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.LOOP][_bgm_pointer]
    bgm.play()

    if _bgm_pointer == len(BGM_COMPONENTS_MAP[_current_bgm][BGM_COMPONENTS.LOOP]) - 1:
        _bgm_pointer = 0
    else:
        _bgm_pointer += 1
    print("[bgm] next section is " + str(_bgm_pointer))


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
        DUCK_SFX_DURATION_SECS
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
        DUCK_SFX_DURATION_SECS
    )
