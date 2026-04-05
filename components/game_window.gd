class_name GameWindow
extends VBoxContainer

@onready var command_prompt: CommandPrompt = %CommandPrompt
@onready var ticker_tape: TickerTape = %TickerTape
@onready var hud_status: HudStatus = %HudStatus
@onready var browser: DynamicPage = $DynamicPage

func _ready() -> void:
    GameState.game_window = self
    command_prompt.enable()
    hud_status.update()

    ticker_tape.unset_dummy_mode()
    ticker_tape.set_text_from_stock_market_data()
    GameState.delayed_tick.connect(ticker_tape.set_text_from_stock_market_data)
