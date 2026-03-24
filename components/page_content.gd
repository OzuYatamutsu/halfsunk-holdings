class_name PageContent
extends Control

@onready var DynamicPageContent: Control = %DynamicPageContent
@export var Title: String
@export var PageHeightY: int

## Call this after updating PageHeightY
## to get scrolling to work properly
func update_scrollable_area() -> void:
    custom_minimum_size = Vector2(0, PageHeightY)
