extends ParallaxBackground

@export var speed:float =120.0

func _ready():
	GameManager.on_game_over.connect(on_game_over)

func _process(delta):
	scroll_offset.x+=speed*delta*-1

func on_game_over()->void:
	set_process(false)
	GameManager.on_game_over.disconnect(on_game_over)
