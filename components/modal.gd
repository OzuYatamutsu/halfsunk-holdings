class_name Modal
extends CanvasLayer

## A Modal is drawn on top of other components drawn on screen
## (and dims the background).

@onready var ModalWindow: Window = $ModalWindow

## If true, ignores attempts to close the window
@export var IgnoreCloseRequests: bool = false


func _ready() -> void:
    ModalWindow.close_requested.connect(_on_close_requested)

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        ModalWindow.close_requested.emit()

func close() -> void:
    ModalWindow.close_requested.emit()

func _on_close_requested() -> void:
    if IgnoreCloseRequests:
        return
    queue_free()
