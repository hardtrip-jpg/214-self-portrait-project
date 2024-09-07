extends CharacterBody3D
class_name Enemy

var current_target : Vector3
var next_target : Vector3

@export var positions : Array[Marker3D]

@export var animation : AnimationPlayer
@export var area : Area3D
@export var nav_agent : NavigationAgent3D

func get_new_pos(delta):
	next_target = nav_agent.get_next_path_position()

func move(delta : float, speed : float):
	var direction := global_position.direction_to(next_target)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	
	move_and_slide()
