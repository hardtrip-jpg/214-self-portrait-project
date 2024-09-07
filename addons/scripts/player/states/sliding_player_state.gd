extends PlayerMovementState
class_name SlidingPlayerState

@export var SPEED: float = 6.0
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25

@export var FOV : float = 100

@export var TILT_AMOUNT : float = 0.03
@export_range(1, 6, 0.1) var SLIDE_ANIM_SPEED : float = 10.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D

func enter(_previous_state) -> void:
	set_tilt(PLAYER._current_rotation)
	ANIMATION.get_animation("sliding").track_set_key_value(4,0,PLAYER.velocity.length())
	ANIMATION.speed_scale = 1.0
	ANIMATION.play("sliding", -1.0, SLIDE_ANIM_SPEED)
	Global.stamina.value -= 35

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_velocity()
	PLAYER.update_fov(delta, FOV)

func set_tilt(player_rotation) -> void:
	var tilt = Vector3.ZERO
	tilt.z = clamp(TILT_AMOUNT * player_rotation, -0.1, 0.1)
	if tilt.z == 0.0:
		tilt.z = 0.05
	ANIMATION.get_animation("sliding").track_set_key_value(2,1,tilt)
	ANIMATION.get_animation("sliding").track_set_key_value(2,2,tilt)
	
	print(ANIMATION.get_animation("sliding").track_get_path(2))

func finish():
	transition.emit("CrouchingPlayerState")
