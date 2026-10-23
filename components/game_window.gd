class_name GameWindow
extends VBoxContainer

@onready var command_prompt: CommandPrompt = %CommandPrompt
@onready var marquee: TickerTape = %TickerTape
@onready var hud_status: HudStatus = %HudStatus
@onready var browser: DynamicPage = $DynamicPage

func _ready() -> void:
    GameState.game_window = self
    command_prompt.enable()
    hud_status.update()


func _input(event):
    if (
        event.is_action_pressed("ui_accept")
        and !GameState.is_in_phase_transition
    ):
        command_prompt.focus()
