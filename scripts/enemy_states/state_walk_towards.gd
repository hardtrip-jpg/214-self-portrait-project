extends EnemyBaseState
class_name WalkTowardsState

@export var speed : float = 1

func extra_ready():
	area.body_entered.connect(body_enter)

func enter(_previous_state) -> void:
	animation.play("stalk_walk")

func update(_delta : float):
	enemy.get_new_pos(_delta)

func physics_update(_delta : float):
	enemy.move(_delta, speed)
	if enemy.current_target == enemy.next_target:
		transition.emit("DetermineLocation")

func body_enter(body : CharacterBody3D):
	if active:
		transition.emit("Transform")
