class_name ChatWindowModal
extends Modal

const ChatMessageComponent: PackedScene = preload("res://components/chat_message.tscn")

## Controls what the text on the bottom will be.
## If only one item is set, the other button will be disabled.
@export var ButtonOptions: Array[String] = ["Yes", "No"]
@export var UserName: String = "Jeff Someguy"
@export var UserTitle: String = "Investment Advisor at Jinhai Holdings"
@export var UserProfilePath: String = "res://components/chat_user_icon_100px.png"

## Pass in a sorted array (oldest to recent) of the form: 
## ["10:01:32/message string", "23:59:59/string2", ...]
@export var ChatMessages: Array[String] = []

## Delegate for what happens when yes button is pressed
@export var YesAction: Callable

## Delegate for what happens when no button is pressed
@export var NoAction: Callable

@onready var chat_messages: VBoxContainer = $ModalWindow/InfoContainer/ChatContainer/ChatMessages
@onready var _test_chat_message: ChatMessage = $ModalWindow/InfoContainer/ChatContainer/ChatMessages/_test_chat_message
@onready var yes_button: Button = %YesButton
@onready var no_button: Button = %NoButton

@onready var _chat_user_profile: TextureRect = %ChatUserProfile
@onready var _chat_user_name: Label = %ChatUserName
@onready var _chat_user_title: Label = %ChatUserTitle


static func Create(script_path: String) -> ChatWindowModal:
    var instance: ChatWindowModal = load("res://components/ChatWindowModal.tscn").instantiate()
    instance.set_script(load(script_path))
    return instance


func _ready() -> void:
    super._ready()

    _test_chat_message.queue_free()
    update_user_info()
    update_button_options()
    preload_chat_messages()
    AudioEngine.play_sfx(AudioEngine.SFX_MESSAGE_RECEIVED)


func update_user_info() -> void:
    _chat_user_profile.texture = load(UserProfilePath)
    _chat_user_name.text = UserName
    _chat_user_title.text = UserTitle


func update_button_options() -> void:
    assert(ButtonOptions != null)
    assert(ButtonOptions.size() > 0)

    yes_button.text = ButtonOptions[0]
    if ButtonOptions.size() == 1:
        no_button.visible = false
        no_button.disabled = true
    else:
        no_button.text = ButtonOptions[1]
        no_button.visible = true
        no_button.disabled = false


func preload_chat_messages() -> void:
    for message in ChatMessages:
        add_message(message)


## Should be of the form: "%TS/message string"
## %TS will be replaced with the current timestamp
func add_message(message: String) -> void:
    var _message: ChatMessage = ChatMessageComponent.instantiate()
    var _timestamp = message.split("/")[0]
    chat_messages.add_child(_message)

    _message.timestamp.text = _timestamp.replace(
        "%TS", GameState.get_current_timestamp_humanized()
    )
    _message.message.text = message.replace(_timestamp + "/", "")


func _on_yes_button_pressed() -> void:
    assert(YesAction != null)
    YesAction.call()


func _on_no_button_pressed() -> void:
    assert(NoAction != null)
    NoAction.call()


## Use this to assign no action to a button
func noop_action() -> void:
    pass


func wait_secs(wait_time: float) -> void:
    await get_tree().create_timer(wait_time).timeout
