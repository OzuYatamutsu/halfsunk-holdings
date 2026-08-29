class_name ChatMessageEvent
extends ChatWindowModal

# Fired when we should advance to the next chat message.
signal advance

# When the advance signal is called, fire the next
# callable in the commands array.
var Commands: Array[Callable] = []


static func CreateChatEvent(
    user_name: String,
    user_title: String,
    user_profile_path: String
) -> ChatMessageEvent:
    var instance: ChatMessageEvent = load(
        "res://components/ChatMessageEvent.tscn"
    ).instantiate()

    instance.UserName = user_name
    instance.UserTitle = user_title
    instance.UserProfilePath = user_profile_path

    return instance


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["(...)"]
    ChatMessages = []
    
    super._ready()
    advance.connect(advance_dialogue)
    advance.emit()

func advance_dialogue() -> void:
    if !Commands.is_empty():
        Commands.pop_front().call()
    else:
        print("end of dialogue")
