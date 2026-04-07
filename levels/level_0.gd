extends Level

func _ready() -> void:
    super()
    _events = {1: _event_chat_message}

func _event_chat_message() -> void:
    pass  # TODO
