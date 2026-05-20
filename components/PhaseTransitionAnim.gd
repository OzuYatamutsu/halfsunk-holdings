class_name PhaseTransitionAnim
extends CanvasLayer

signal animation_complete

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var hud_status: HudStatus
var _impostor_hud_status: HudStatus

func _ready() -> void:
    hud_status = GameState.game_window.hud_status
    hud_status.set_days_arbitrary("PREMARKET")
    
    _impostor_hud_status = hud_status.duplicate()
    _impostor_hud_status.alignment = BoxContainer.ALIGNMENT_END
    _impostor_hud_status.set_anchors_preset(Control.LayoutPreset.PRESET_TOP_WIDE)
    _impostor_hud_status.position = Vector2(0, 0)
    add_child(_impostor_hud_status)

    AudioEngine.play_sfx(AudioEngine.SFX_WATCH_BEEP)
    animation_player.play("on_load")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
    remove_child(_impostor_hud_status)
    hud_status.update()
    animation_complete.emit()
