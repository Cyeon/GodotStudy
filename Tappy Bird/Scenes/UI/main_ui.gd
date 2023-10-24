extends Control

@onready var score_label = $TextureRect/MarginContainer/HBoxContainer/ScoreLabel
@onready var high_score_label = $TextureRect/MarginContainer/HBoxContainer/HighScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text="SCORE "+str(GameManager.get_score())
	high_score_label.text="HIGH " + str(GameManager.get_high_score())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fly") :
		GameManager.load_game_scene()
