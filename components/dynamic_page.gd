class_name DynamicPage
extends VBoxContainer

## A DynamicPage expects a PageTitle and a single node
## in the page_contents group. Call actually_ready()
## after these have been assigned.

@onready var PageTitleLabel: Label = $DynamicPageTitle/PageTitleLabel
@onready var DynamicPageScroller: ScrollContainer = $DynamicPageScroller
@onready var DynamicPageContents: PageContent = $DynamicPageScroller/DynamicPageContents

@export var PageTitle: String = ""

func _ready() -> void:
    pass

func load_page(path_to_page_content: String) -> void:
    var page_content: PageContent = load(path_to_page_content).instantiate()

    DynamicPageScroller.remove_child(DynamicPageContents)
    DynamicPageContents = page_content
    DynamicPageScroller.add_child(DynamicPageContents)
    PageTitle = DynamicPageContents.Title
    PageTitleLabel.text = PageTitle
