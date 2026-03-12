# ModalWindow
extends Window

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        close_requested.emit()
