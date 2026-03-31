class_name ChatWindowModal
extends Modal

const ChatMessageComponent: PackedScene = preload("res://components/chat_message.tscn")

@onready var chat_messages: VBoxContainer = $ModalWindow/InfoContainer/ChatContainer/ChatMessages
@onready var _test_chat_message: ChatMessage = $ModalWindow/InfoContainer/ChatContainer/ChatMessages/_test_chat_message


func _ready() -> void:
    _test_chat_message.queue_free()


## Pass in a sorted array (oldest to recent) of the form: 
## ["10:01:32 message string", "23:59:59 string2", ...]
func preload_chat_messages(messages: Array[String]) -> void:
    for message in messages:
        var _message: ChatMessage = ChatMessageComponent.instantiate()
        var _timestamp = message.split(" ")[0]

        _message.timestamp = _timestamp
        _message.message.text = message.replace(_timestamp + " ", "")
        
        chat_messages.add_child(_message)


func _on_yes_button_pressed() -> void:
    pass  # TODO


func _on_no_button_pressed() -> void:
    pass  # TODO
