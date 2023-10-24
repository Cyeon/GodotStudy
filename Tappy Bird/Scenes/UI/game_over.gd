extends Control

@onready var timer = $Timer
@onready var press_space_label = $PressSpaceLabel

var ready_to_load:bool=false

func _ready():
	GameManager.on_game_over.connect(on_game_over)

func on_game_over() -> void:
	show()
	timer.start()

func run_sequence() -> void:
	press_space_label.show()
	ready_to_load = true

func _on_timer_timeout():
	run_sequence()

func _process(delta):
	if ready_to_load && Input.is_action_just_pressed("fly"):
		GameManager.load_menu_scene()
