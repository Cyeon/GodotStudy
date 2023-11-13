extends Area2D

@onready var splash_sound = $SplashSound


func _on_body_entered(body : RigidBody2D):
	if body.is_in_group(GameManager.GROUP_ANIMAL) : 
		splash_sound.play()
