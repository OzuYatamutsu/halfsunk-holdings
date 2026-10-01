class_name FakeTickerTape
extends Control

const DUMMY_TEXT := "CAT 223.25 [color=green]↗ 22.05[/color] ([color=green]+10.96%[/color])  |  BIRD 415.28 [color=green]↗ 22.05[/color] ([color=green]+5.61%[/color])  |  DOG 15.26 [color=red]↘ 1.06[/color] ([color=red]−6.50%[/color])  |  CRW 12.48 [color=red]↘ 1.14[/color] ([color=red]−8.37%[/color])  |  SNEK 66.66 [color=green]↗ 0.22[/color] ([color=green]+0.33%[/color])  |  TIGR 21.14 [color=green]↗ 0.22[/color] ([color=green]+1.05%[/color])  |  LZRD 67.69 [color=green]↗ 0.69[/color] ([color=green]+1.03%[/color])  |  "

@export var speed_px_per_sec: float = 100.0

@onready var _label: RichTextLabel = %Label
@onready var _label2: RichTextLabel = %Label2

## Simulates infinite scrolling text using two
## repeated labels which loop back on top of
## each other when it gets to the edge of the
## screen.

var _running := true

func _ready():
    await _apply_text()
    _reset_positions()

func _apply_text():
    _label.text = DUMMY_TEXT
    _label2.text = DUMMY_TEXT

    await get_tree().process_frame
    speed_px_per_sec = _label.size.x / 10.0

func _reset_positions():
    _label.position.x = 0
    _label2.position.x = _label.size.x

func _process(delta: float):
    if !_running:
        return

    var dx := speed_px_per_sec * delta

    _label.position.x -= dx
    _label2.position.x -= dx

    # when label exits left, recycle it
    if _label.position.x + _label.size.x < 0:
        _label.position.x = _label2.position.x + _label2.size.x

    if _label2.position.x + _label2.size.x < 0:
        _label2.position.x = _label.position.x + _label.size.x

func start():
    _running = true

func stop():
    _running = false
