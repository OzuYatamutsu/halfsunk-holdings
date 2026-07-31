class_name ChatMessage
extends GridContainer

static var THEME_REPLY: Theme = load("res://components/TextReply.tres")

@onready var timestamp: Label = $Timestamp
@onready var message: Label = $Message
