class_name GameWindow
extends Control

@onready var command_prompt: CommandPrompt = %CommandPrompt
@onready var marquee: Marquee = %Marquee
@onready var hud_status: HudStatus = %HudStatus

func _ready() -> void:
    command_prompt.enable()
    hud_status.update()
    marquee.unset_dummy_mode()
