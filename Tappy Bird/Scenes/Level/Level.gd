extends Node2D

@export var pipes_scene : PackedScene

@onready var pipe_holder = $PipeHolder
@onready var spawn_upper = $PipeHolder/SpawnUpper
@onready var spawn_lower = $PipeHolder/SpawnLower
@onready var timer = $Timer
@onready var engine_sound = $EngineSound
@onready var game_over_sound = $GameOverSound

func _ready():
	GameManager.set_score(0)
	GameManager.on_game_over.connect(on_game_over)
	spawn_pipes()

func spawn_pipes()->void:
	var y_pos : float = randf_range(
		spawn_upper.position.y,spawn_lower.position.y)
		
	var new_pipes = pipes_scene.instantiate() as Node2D
	new_pipes.position = Vector2(spawn_lower.position.x	, y_pos)
	pipe_holder.add_child(new_pipes)
	
func stop_all_pipes()->void:
	timer.stop() # 스폰 타이머 정지 
	for p in pipe_holder.get_children() :
		p.set_process(false)

func on_game_over()->void:
	GameManager.on_game_over.disconnect(on_game_over)
	stop_all_pipes()
	
	engine_sound.stop()
	game_over_sound.play()

func _on_timer_timeout():
	spawn_pipes()

func _on_plane_died():
	GameManager.load_menu_scene()
