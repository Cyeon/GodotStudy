extends TextureButton

const HOVER_SCALE : Vector2 = Vector2(1.1, 1.1)
const DEFAULT_SCALE : Vector2 = Vector2(1.0, 1.0)

@export var level_number : int = 1

@onready var level_label = %LevelLabel
@onready var score_label = %ScoreLabel

func _ready():
	level_label.text = str(level_number)

func _on_pressed():
	pass # Replace with function body.


func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.
