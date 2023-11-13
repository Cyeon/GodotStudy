extends Node2D

var animal_scene:PackedScene=preload("res://scenes/Animal/animal.tscn")
@onready var debug_label = $DebugLabel
@onready var animal_start = $AnimalStart


func _ready():
	SignalManager.on_update_debug_label.connect(on_update_label)
	SignalManager.on_animal_died.connect(on_animal_die)
	create_animal()

func on_update_label(text:String)->void:
	debug_label.text=text;

func on_animal_die()->void:
	create_animal()
	
func create_animal()->void:
	var animal:=animal_scene.instantiate() as RigidBody2D
	animal.global_position=animal_start.position
	add_child(animal) # 새로 생성한 애니멀을 트리에 넣어줌

# unity의 온 디스트로이, 온 디스에이블드 
func _exit_tree():
	SignalManager.on_update_debug_label.disconnect(on_update_label)
	SignalManager.on_animal_died.disconnect(on_animal_die)
