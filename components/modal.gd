class_name Modal
extends CanvasLayer

## A Modal is drawn on top of other components drawn on screen
## (and dims the background).

@onready var ModalWindow: Window = $ModalWindow

func _ready() -> void:
    ModalWindow.close_requested.connect(_on_close_requested)
    
func _on_close_requested() -> void:
    queue_free()
