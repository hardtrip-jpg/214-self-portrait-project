extends CharacterBody3D
class_name Enemy

var current_target : Vector3
var next_target : Vector3

@export var positions : Array[Marker3D]

@export var animation : AnimationPlayer
@export var area : Area3D
@export var nav_agent : NavigationAgent3D
@export var mesh : Node3D
@export var audio_voice : AudioStreamPlayer3D

@export var got : Area3D

func _ready() -> void:
	got.body_entered.connect(gotted)

func get_new_pos(delta):
	next_target = nav_agent.get_next_path_position()

func move(delta : float, speed : float):
	var direction := global_position.direction_to(next_target)
	
	set_angle(Vector2(direction.x, -direction.z))
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	
	move_and_slide()

func set_angle(vector : Vector2):
	var mesh_angle := Vector2.UP.angle_to(vector)
	mesh.rotation.y = mesh_angle

func gotted(body : CharacterBody3D):
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
