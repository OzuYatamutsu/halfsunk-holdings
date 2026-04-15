class_name PremarketStartAnim
extends CanvasLayer

signal animation_complete

@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
    animation_player.play("on_load")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
    animation_complete.emit()
