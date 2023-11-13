extends StaticBody2D

class_name Cup

@onready var vanish_sound = $VanishSound
@onready var animation_player = $AnimationPlayer

var is_dead : bool = false

func die() -> void : 
	if is_dead : 
		return
	
	vanish_sound.play()
	animation_player.play("vanish")
	
func on_vanish_sound_finish() -> void : 
	SignalManager.on_cup_destroyed.emit()
	queue_free()
