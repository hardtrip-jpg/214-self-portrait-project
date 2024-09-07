extends CharacterBody3D
class_name PlayerController


@export var MOUSE_SENSITIVITY := 0.6
@export var DRAG_WEIGHT := 6
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)

@export var CAMERA_CONTROLLER : Camera3D
@export var ANIMATION_PLAYER : AnimationPlayer
@export var CROUCH_SHAPECAST : ShapeCast3D



@export var init_rotation : float


var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var _mouse_velocity : Vector2
var _player_rotation : Vector3
var _camera_rotation : Vector3

var _current_rotation : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


 
func _unhandled_input(event):
	#Determine mouse movement
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY

func _update_camera(delta):
	#Get Look Velocity
	var _pre_mouse_velocity = Vector2(_tilt_input, _rotation_input)
	
	
	_mouse_velocity = lerp(_mouse_velocity, _pre_mouse_velocity, delta * DRAG_WEIGHT)
	
	_current_rotation = _mouse_velocity.y
	
	#Set Rotation
	_mouse_rotation.x += _mouse_velocity.x  * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _mouse_velocity.y * delta
	
	#Apply Rotation
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = lerp_angle(CAMERA_CONTROLLER.rotation.z, (deg_to_rad(2) * _mouse_velocity.y), 0.25)
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	#Reset Mouse Inputs
	_rotation_input = 0.0
	_tilt_input = 0.0

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta):
	
	_update_camera(delta)
	
	


#Calculations
func update_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		var vel = Vector2(velocity.x, velocity.z)
		var temp = move_toward(vel.length(),0, deceleration)
		velocity.x = vel.normalized().x * temp
		velocity.z = vel.normalized().y * temp

func update_velocity() -> void:
	move_and_slide()

func update_fov(delta, fov: float) -> void:
	CAMERA_CONTROLLER.fov = lerp(CAMERA_CONTROLLER.fov, fov, delta * 3)
