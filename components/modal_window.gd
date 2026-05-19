# ModalWindow
extends Window


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        close_requested.emit()
    if event.is_action_pressed("ui_accept"):
        # Enter key should default to whatever
        # the yes option is
        get_parent()._on_yes_button_pressed()
