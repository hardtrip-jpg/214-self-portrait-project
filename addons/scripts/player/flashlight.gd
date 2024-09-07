extends SpotLight3D
class_name Flashlight

@export var distance : float = 3
@export var weight : float = 0.1
@export var player : PlayerController



func _physics_process(delta):
	if visible:
		set_rotation_motion(delta)


func flashlight_switch() -> void:
	visible = !visible

func set_rotation_motion(_delta : float) -> void:
	
	var mouse_velocity = player._mouse_velocity
	
	var cur_rot = Vector3(mouse_velocity.x * distance, mouse_velocity.y * distance, 0)
	
	rotation_degrees = lerp(rotation_degrees, cur_rot, weight)
