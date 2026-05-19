class_name Modal
extends CanvasLayer


## A Modal is drawn on top of other components drawn on screen
## (and dims the background).

const _FREE_DELAY_SECS: float = 0.05
const _MODAL_GROUP: String = "_modal"

@onready var ModalWindow: Window = $ModalWindow

## If true, ignores attempts to close the window
@export var IgnoreCloseRequests: bool = false


func _ready() -> void:
    # Ensure only one modal is active
    if get_tree().get_first_node_in_group(_MODAL_GROUP):
        get_tree().get_first_node_in_group(_MODAL_GROUP).queue_free()
    ModalWindow.close_requested.connect(_on_close_requested)
    add_to_group(_MODAL_GROUP)

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        ModalWindow.close_requested.emit()

func close() -> void:
    ModalWindow.close_requested.emit()

func _on_close_requested() -> void:
    if IgnoreCloseRequests:
        return
    
    # Delayed close
    visible = false
    await get_tree().create_timer(_FREE_DELAY_SECS).timeout
    queue_free()
