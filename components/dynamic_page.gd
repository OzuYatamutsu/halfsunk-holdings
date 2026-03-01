class_name DynamicPage
extends VBoxContainer

## A DynamicPage expects a PageTitle and a single node
## in the page_contents group. Call actually_ready()
## after these have been assigned.

const KEYBOARD_SCROLL_SPEED: int = 75

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

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_up"):
        keyboard_scroll_up()
    elif event.is_action_pressed("ui_down"):
        keyboard_scroll_down()

func keyboard_scroll_up() -> void:
    DynamicPageScroller.scroll_vertical -= KEYBOARD_SCROLL_SPEED

func keyboard_scroll_down() -> void:
    DynamicPageScroller.scroll_vertical += KEYBOARD_SCROLL_SPEED
