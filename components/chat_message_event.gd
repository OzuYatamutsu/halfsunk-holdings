class_name ChatMessageEvent
extends ChatWindowModal

# Fired when we should advance to the next chat message.
signal advance

# When the advance signal is 
var Commands: Array[Callable] = []


func _init(user_name: String, user_title: String, user_profile_path: String):
    UserName = user_name
    UserTitle = user_title
    UserProfilePath = user_profile_path


func _ready() -> void:
    IgnoreCloseRequests = true
    ButtonOptions = ["(...)"]
    ChatMessages = []
    
    super._ready()
    advance.connect(advance_dialogue)


func advance_dialogue() -> void:
    if !Commands.is_empty():
        Commands.pop_front().call()
    else:
        print("end of dialogue")
