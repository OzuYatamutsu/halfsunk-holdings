extends ChatWindowModal

func _ready() -> void:
    ButtonOptions = ["OK!"]
    UserName = "Awre Twelve"
    UserTitle = "Hedge Fund Manager at Corvid Group"
    UserProfilePath = "res://components/pfp_awre_twelve.png"
    ChatMessages = [
        "%s/hi want some terrible investment advice" % [GameState.get_current_timestamp_humanized()]
    ]
    YesAction = _0_on_yes_button_pressed

    super._ready()

func _0_on_yes_button_pressed() -> void:
    pass
