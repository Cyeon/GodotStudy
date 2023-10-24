extends ParallaxLayer

@onready var sprite_2d = $Sprite2D
@export var texture : Texture
@export var scroll_scale : float=0.0
@export var texture_width:float =1920.0
@export var texture_height:float = 1080.0

func _ready():
	motion_scale.x=scroll_scale
	var scale_factor : float = get_viewport_rect().size.y / texture_height
	sprite_2d.texture = texture
	sprite_2d.scale = Vector2.ONE * scale_factor
	
	motion_mirroring.x = texture_width * scale_factor
