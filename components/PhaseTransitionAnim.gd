class_name PhaseTransitionAnim
extends CanvasLayer

signal animation_complete

@onready var animation_player: AnimationPlayer = %AnimationPlayer
var hud_status: HudStatus
var _impostor_hud_status: HudStatus
var days_arbitrary_text: String
var is_in_end_of_week_calculation: bool = false


func _ready() -> void:
    GameState.is_in_phase_transition = true
    hud_status = GameState.game_window.hud_status
    hud_status.set_days_arbitrary(days_arbitrary_text)

    _impostor_hud_status = hud_status.duplicate()
    _impostor_hud_status.alignment = BoxContainer.ALIGNMENT_END
    _impostor_hud_status.set_anchors_preset(Control.LayoutPreset.PRESET_TOP_WIDE)
    _impostor_hud_status.position = Vector2(0, 0)
    add_child(_impostor_hud_status)
    _blink_fake_impostor_hud_status()

    AudioEngine.play_sfx(AudioEngine.SFX_WATCH_BEEP)
    animation_player.play("on_load")


func _blink_fake_impostor_hud_status() -> void:
    var tween = create_tween()
    if is_in_end_of_week_calculation:
        tween.set_loops(1)
    else:
        tween.set_loops()
    tween.tween_callback(func(): _impostor_hud_status.visible = true)
    tween.tween_interval(0.4)
    tween.tween_callback(func(): _impostor_hud_status.visible = false)
    tween.tween_interval(0.4)
    tween.tween_callback(func(): _impostor_hud_status.visible = true)
    tween.tween_interval(0.4)
    tween.tween_callback(func(): _impostor_hud_status.visible = false)
    tween.tween_interval(0.4)
    tween.tween_callback(func(): _impostor_hud_status.visible = true)
    tween.tween_interval(0.4)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
    GameState.is_in_phase_transition = false
    remove_child(_impostor_hud_status)
    _impostor_hud_status.queue_free()
    hud_status.update()
    animation_complete.emit()
    queue_free()
