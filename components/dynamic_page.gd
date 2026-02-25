class_name DynamicPage
extends VBoxContainer

## A DynamicPage expects a PageTitle and a single node
## in the page_contents group. Call actually_ready()
## after these have been assigned.

@onready var PageTitleLabel: Label = $DynamicPageTitle/PageTitleLabel
@onready var DynamicPageContents: Control = $DynamicPageContents

@export var PageTitle: String = ""

func _ready() -> void:
    pass

func actually_ready() -> void:
    PageTitleLabel.text = PageTitle
    DynamicPageContents = get_tree().get_first_node_in_group("page_contents")
