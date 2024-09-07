extends PlayerMovementState
class_name CrouchingPlayerState

@export var SPEED : float = 1.5
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export_range(1, 6, 0.1) var CROUCH_SPEED : float = 4.0

@export var FOV : float = 85

@export var TOP_ANIM_SPEED : float = 1.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D

var RELEASED : bool = false
var CROUCHED : bool = false

func enter(previous_state) -> void:
	ANIMATION.speed_scale = 1.0
	if previous_state.name != "SlidingPlayerState":
		ANIMATION.play("crouch", -1.0, CROUCH_SPEED)
		await ANIMATION.animation_finished
		CROUCHED = true
	elif previous_state.name == "SlidingPlayerState":
		ANIMATION.current_animation = "crouch"
		ANIMATION.seek(1.0, true)
	ANIMATION.play("crouch_walking", -1.0, 1.0)

func exit():
	ANIMATION.speed_scale = 1.0
	RELEASED = false

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	PLAYER.update_fov(delta, FOV)
	
	if CROUCHED:
		set_animation_speed(PLAYER.velocity.length())
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
	elif Input.is_action_pressed("crouch") == false and RELEASED == false:
		RELEASED = true
		uncrouch()

func uncrouch():
	if CROUCH_SHAPECAST.is_colliding() == false:
		ANIMATION.speed_scale = 1.0
		CROUCHED = false
		ANIMATION.play("crouch", -1.0, -CROUCH_SPEED * 1.5, true)
		if ANIMATION.is_playing():
			await ANIMATION.animation_finished
		transition.emit("IdlePlayerState")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
