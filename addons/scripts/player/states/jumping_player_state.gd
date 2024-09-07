extends PlayerMovementState
class_name JumpingPlayerState

@export var SPEED : float = 5.0
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export var JUMP_VELOCITY : float = 4.5
@export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLAYER : float = 0.85

func enter(_previous_state) -> void:
	PLAYER.velocity.y += JUMP_VELOCITY
	ANIMATION.play("jumpStart")
	Global.stamina.value -= 20

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * INPUT_MULTIPLAYER, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("jump"):
		if PLAYER.velocity.y > 0:
			PLAYER.velocity.y = PLAYER.velocity.y / 2.0
	
	if PLAYER.is_on_floor():
		ANIMATION.play("jumpEnd")
		transition.emit("IdlePlayerState")
