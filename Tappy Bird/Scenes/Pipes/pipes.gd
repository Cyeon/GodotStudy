extends Node2D

const SCROLL_SPEED:float = 120.0
@onready var score_player = $ScorePlayer

func _ready():
	pass # Replace with function body.

func _process(delta):
	position.x -= SCROLL_SPEED * delta


func _on_screen_exited():
	queue_free()


func _on_pipe_body_entered(body):
	# 무조건 플레이어 
	
	# Unity CompaerTag
#	if body.is_in_group(GameManager.GROUP_PLAYER):
	
	var player = body as PlayerController 
	if not player:
		return
	
	player.die()

func _on_lazer_body_entered(body):
#	if body.is_in_group(GameManager.GROUP_PLAYER):
	var player = body as PlayerController 
	if player:
		player_scored()

func player_scored() -> void:
	GameManager.increment_score()
	score_player.play()
