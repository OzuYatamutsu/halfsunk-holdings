class_name CommandPrompt
extends Control

## To add a command handler to the list,
var COMMAND_LIST: Dictionary[String, Callable] = {
    "NOOP": _handle_noop
}

@export var IsEnabled: bool = true

@onready var PromptEdit: LineEdit = $PromptEdit
@onready var NotFoundStatusText: Label = %NotFoundStatusText
@onready var DisabledFg: ColorRect = %DisabledFg

func _ready() -> void:
    NotFoundStatusText.visible = false

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

func _handle_command_not_found() -> void:
    # Flash not found text for a tiny amount of time
    NotFoundStatusText.visible = true
    var status_flash = create_tween()
    status_flash.tween_interval(1.0)
    status_flash.tween_callback(func():
        NotFoundStatusText.visible = false
    )

## This command does nothing
func _handle_noop(_args: Array[String]) -> void:
    pass
