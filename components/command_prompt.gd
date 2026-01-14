class_name CommandPrompt
extends Control

@onready var PromptEdit: LineEdit = $PromptEdit

func _ready() -> void:
    pass

func _on_prompt_edit_text_submitted(new_text: String) -> void:
    # TODO parse and read command
    PromptEdit.clear()
