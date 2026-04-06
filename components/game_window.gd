class_name GameWindow
extends VBoxContainer

@onready var command_prompt: CommandPrompt = %CommandPrompt
@onready var marquee: Marquee = %Marquee
@onready var hud_status: HudStatus = %HudStatus
@onready var browser: DynamicPage = $DynamicPage

func _ready() -> void:
    GameState.game_window = self
    command_prompt.enable()
    hud_status.update()

    marquee.unset_dummy_mode()
    marquee.set_text_from_stock_market_data()
    marquee.start()
    GameState.delayed_tick.connect(marquee.set_text_from_stock_market_data)
