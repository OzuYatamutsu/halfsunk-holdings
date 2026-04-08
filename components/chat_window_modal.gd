class_name ChatWindowModal
extends Modal

const ChatMessageComponent: PackedScene = preload("res://components/chat_message.tscn")

## Controls what the text on the bottom will be.
## If only one item is set, the other button will be disabled.
@export var ButtonOptions: Array[String] = ["Yes", "No"]
@export var UserName: String = "Jeff Someguy"
@export var UserTitle: String = "Investment Advisor at Jinhai Holdings"
@export var UserProfilePath: String = "res://components/chat_user_icon_100px.png"

@onready var chat_messages: VBoxContainer = $ModalWindow/InfoContainer/ChatContainer/ChatMessages
@onready var _test_chat_message: ChatMessage = $ModalWindow/InfoContainer/ChatContainer/ChatMessages/_test_chat_message
@onready var yes_button: Button = %YesButton
@onready var no_button: Button = %NoButton

@onready var _chat_user_profile: TextureRect = %ChatUserProfile
@onready var _chat_user_name: Label = %ChatUserName
@onready var _chat_user_title: Label = %ChatUserTitle


func _ready() -> void:
    _test_chat_message.queue_free()
    update_user_info()
    update_button_options()


func update_user_info() -> void:
    _chat_user_profile.texture = load(UserProfilePath)
    _chat_user_name.text = UserName
    _chat_user_title.text = UserTitle


func update_button_options() -> void:
    yes_button.text = ButtonOptions[0]
    if ButtonOptions.size() > 1:
        no_button.visible = false
        no_button.disabled = true
    else:
        no_button.text = ButtonOptions[1]
        no_button.visible = true
        no_button.disabled = false


## Pass in a sorted array (oldest to recent) of the form: 
## ["10:01:32 message string", "23:59:59 string2", ...]
func preload_chat_messages(messages: Array[String]) -> void:
    for message in messages:
        var _message: ChatMessage = ChatMessageComponent.instantiate()
        var _timestamp = message.split(" ")[0]
        chat_messages.add_child(_message)

        _message.timestamp.text = _timestamp
        _message.message.text = message.replace(_timestamp + " ", "")
        

func _on_yes_button_pressed() -> void:
    pass  # TODO


func _on_no_button_pressed() -> void:
    pass  # TODO
