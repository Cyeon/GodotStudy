extends CharacterBody2D # 상속

# @export -> SerializeField 같은 거 
@export var gravity: float = 1000.0
@export var power: float = -400.0

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D

# _ready = Start
#  _process(delta) = update

# -> void 는 void 타입을 리턴한다는 뜻 
func _physics_process(delta)->void:
	apply_gravity(delta)
	fly()
	move_and_slide()
	
	if is_on_floor(): # 땅에 닿았으면
		die()

func fly()->void:
	if Input.is_action_just_pressed("fly"):
		velocity.y=power
		animation_player.play("fly_to")
		# print("vel %f, %f" % [velocity.x, velocity.y])

func apply_gravity(delta:float)->void:
	velocity.y += gravity * delta

func die()->void:
	animated_sprite_2d.stop()
	set_physics_process(false)
	# queue_free()
