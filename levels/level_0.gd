extends Level



func _ready() -> void:
    super()
    _events = {1: _event_chat_message}

func _event_chat_message() -> void:
    var chat_window: ChatWindowModal = ChatWindowModal.Create(
        "res://events/day0_test_message1.gd"
    )
    window.add_child(chat_window)
