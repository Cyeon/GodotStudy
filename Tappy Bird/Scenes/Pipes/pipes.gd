extends Node2D

const SCROLL_SPEED:float = 120.0

func _ready():
	pass # Replace with function body.

func _process(delta):
	position.x -= SCROLL_SPEED * delta


func _on_screen_exited():
	queue_free()
