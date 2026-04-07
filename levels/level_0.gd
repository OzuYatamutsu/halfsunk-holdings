extends Level



func _ready() -> void:
    super()
    _events = {1: _event_chat_message}

func _event_chat_message() -> void:
    var chat_window: ChatWindowModal = load("res://components/ChatWindowModal.tscn").instantiate()
    window.add_child(chat_window)
    chat_window.preload_chat_messages([
        str(GameState.get_current_timestamp()) + " hi want some terrible investment advice"
    ])
    AudioEngine.play_sfx(AudioEngine.SFX_MESSAGE_RECEIVED)
