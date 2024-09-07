extends PlayerMovementState
class_name SprintingPlayerState

@export var SPEED: float = 5.0
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25

@export var FOV : float = 93

@export var TOP_ANIM_SPEED : float = 1.4

func enter(_previous_state) -> void:
	#if ANIMATION.is_playing() and ANIMATION.current_animation == "jumpEnd":
		#await ANIMATION.animation_finished
	ANIMATION.play("sprinting", -1.0, 1.0)

func exit() -> void:
	ANIMATION.speed_scale = 1.0

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	PLAYER.update_fov(delta, FOV)
	
	Global.stamina.value -= 0.7
	
	set_animation_speed(PLAYER.velocity.length())
	
	if Input.is_action_just_released("sprint") or PLAYER.velocity.length() == 0 or Global.stamina.value <= 0:
		transition.emit("WalkingPlayerState")
	
	if Input.is_action_just_pressed("crouch") and PLAYER.velocity.length() > 4:
		transition.emit("SlidingPlayerState")
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor() and Global.stamina.value > 0:
		transition.emit("JumpingPlayerState")

func set_animation_speed(spd) -> void:
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
