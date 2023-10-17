extends Node2D

@export var pipes_scene : PackedScene

@onready var pipe_holder = $PipeHolder
@onready var spawn_upper = $PipeHolder/SpawnUpper
@onready var spawn_lower = $PipeHolder/SpawnLower
@onready var timer = $Timer

func _ready():
	spawn_pipes()

func spawn_pipes()->void:
	var y_pos : float = randf_range(
		spawn_upper.position.y,spawn_lower.position.y)
		
	var new_pipes = pipes_scene.instantiate() as Node2D
	new_pipes.position = Vector2(spawn_lower.position.x	, y_pos)
	pipe_holder.add_child(new_pipes)


func _on_timer_timeout():
	spawn_pipes()
