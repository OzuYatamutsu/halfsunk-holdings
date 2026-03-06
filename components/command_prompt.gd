class_name CommandPrompt
extends Control

## To add a command handler to the list,
var COMMAND_LIST: Dictionary[String, Callable] = {
    "NOOP": _handle_noop,
    "INFO": _handle_info,
}

@export var IsEnabled: bool = true

@onready var PromptEdit: LineEdit = $PromptEdit
@onready var NotFoundStatusText: Label = %NotFoundStatusText
@onready var StatusText: Label = %StatusText
@onready var DisabledFg: ColorRect = %DisabledFg

func _ready() -> void:
    NotFoundStatusText.visible = false
    StatusText.visible = false

func clear() -> void:
    PromptEdit.clear()

func disable() -> void:
    IsEnabled = false
    PromptEdit.editable = false
    DisabledFg.visible = true

func enable() -> void:
    IsEnabled = true
    PromptEdit.editable = true
    DisabledFg.visible = false

func _on_prompt_edit_text_submitted(new_text: String) -> void:
    if new_text.length() == 0:
        return

    var command = new_text.split(" ")[0]
    var command_args = new_text.split(" ")
    command_args.remove_at(0)

    if !(command in COMMAND_LIST):
        _handle_command_not_found()
    else:
        COMMAND_LIST[command].call(command_args)
    PromptEdit.clear()


## Flash not found text for a tiny amount of time
func _handle_command_not_found() -> void:
    NotFoundStatusText.visible = true
    var status_flash = create_tween()
    status_flash.tween_interval(1.0)
    status_flash.tween_callback(func():
        NotFoundStatusText.visible = false
    )

## Flash status text for a tiny amount of time
func _flash_status_text(text: String) -> void:
    StatusText.text = text
    StatusText.visible = true
    var status_flash = create_tween()
    status_flash.tween_interval(1.0)
    status_flash.tween_callback(func():
        StatusText.visible = false
    )


## This command does nothing
func _handle_noop(_args: Array[String]) -> void:
    pass

## This command loads the Stock Screener (if the ticker exists)
func _handle_info(args: Array[String]) -> void:
    # Check if the command is malformed
    if (len(args) != 1):
        _flash_status_text("Syntax: INFO <stock-ticker>")
        return

    # Check if the stock actually exists in the stock market
    var stock = GameState.stock_market.get_stock(args[0])
    if (!stock):
        _flash_status_text("Stock not found!")
        return

    # If so, trigger a load of the Stock Screener
    GameState.switch_page_data_bus = args[0]
    GameState.game_window.browser.load_page("res://pages/StockScreener.tscn")
