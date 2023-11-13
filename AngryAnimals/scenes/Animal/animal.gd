extends RigidBody2D


@export var drag_limit_max:Vector2 = Vector2(0, 60)
@export var drag_limit_min:Vector2 = Vector2(-60, 0)
@export var fire_delay: float = 0.25

@onready var launch_sound = %LaunchSound
@onready var stretch_sound = %StretchSound
@onready var collision_sound = %CollisionSound


var _is_dead:bool = false
var _dragging:bool = false
var _released:bool = false
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _last_dragged_position: Vector2 = Vector2.ZERO
var _last_drag_amount: float = 0.0
var _fired_time: float = 0.0
var _last_collision_count: int = 0

const STOPPED : float = 0.1

func _ready():
	_start = global_position

func _physics_process(delta):
	update_debug_label()
	
	if _released :
		_fired_time += delta
		if _fired_time > fire_delay :
			check_collision()
			check_on_target()
	else:
		if _dragging == false :
			return
		elif Input.is_action_just_released("drag"):
			release_it()
		else:
			drag_it()

func is_stop_rolling() -> bool : 
	var is_stop : bool = get_contact_count() > 0 && \
		abs(linear_velocity.y) < STOPPED && abs(angular_velocity) < STOPPED
	
	return is_stop
	
func check_on_target() -> void : 
	if is_stop_rolling() == false :
		return
	var collision_bodies : Array[Node2D] = get_colliding_bodies()
	if collision_bodies.size() == 0 : 
		return 
	if collision_bodies[0].is_in_group(GameManager.GROUP_CUP) : 
		var cup : Cup = collision_bodies[0] as Cup
		if cup : 
			cup.die()
		die()

func grab_it()->void:
	_dragging = true
	_drag_start = get_global_mouse_position() #마우스 위치 잡고
	_last_dragged_position = _drag_start


func drag_it()->void:
	var gmp: Vector2 = get_global_mouse_position()
	_last_drag_amount = (_last_dragged_position - gmp).length()
	_last_dragged_position = gmp

	if _last_drag_amount > 0 and stretch_sound.playing == false:
		stretch_sound.play()
	
	_dragged_vector = gmp - _drag_start
	
	#최대치로 클램프 
	_dragged_vector.x = clamp(_dragged_vector.x, drag_limit_min.x, drag_limit_max.x)
	_dragged_vector.y = clamp(_dragged_vector.y, drag_limit_min.y, drag_limit_max.y)
	
	global_position = _start + _dragged_vector


func release_it()->void:
	_dragging = false
	_fired_time = 0
	_released = true
	freeze = false
	apply_central_impulse(_dragged_vector * -1 * 20.0)
	stretch_sound.stop()
	launch_sound.play()

func update_debug_label()->void :
	var s: String = "g_pos: %s, \n ang: %.1f\n linear: %s\n \
					drag : %s, release: %s\n \
					start: %s, dragStart: %s, dragVec: %s\n \
					lastDragPos: %s, lastDragAmount: %f" % [
		Utils.vec2_to_str(global_position),
		angular_velocity,
		Utils.vec2_to_str(linear_velocity),
		_dragging,
		_released,
		Utils.vec2_to_str(_start),
		Utils.vec2_to_str(_drag_start),
		Utils.vec2_to_str(_dragged_vector),
		Utils.vec2_to_str(_last_dragged_position),
		_last_drag_amount
	]
	SignalManager.on_update_debug_label.emit(s)



func _on_screen_exited():
	die()    


func die()->void:
	if _is_dead : 
		return
	
	_is_dead = true
	#사망하면 다시 생성.
	SignalManager.on_animal_died.emit()
	queue_free() #유니티의 Destroy와 같다.



@warning_ignore("unused_parameter")
func _on_input_event(viewport, event: InputEvent, shape_idx):
	if _dragging or _released :
		return
	
	if event.is_action_pressed("drag") :
		grab_it()
	

func check_collision()->void:
	var current_contact = get_contact_count()
	
	var is_contact: bool = _last_collision_count == 0 and \
			current_contact > 0 and \
			collision_sound.playing == false
	
	if is_contact :
		collision_sound.play()
	
	_last_collision_count = current_contact
