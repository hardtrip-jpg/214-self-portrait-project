extends EnemyBaseState
class_name WaitState

@export var timer : Timer

func extra_ready():
	area.body_entered.connect(body_enter)
	timer.timeout.connect(timeout)

func enter(_previous_state) -> void:
	animation.play("stalk_idle")
	timer.start()

func body_enter(body : CharacterBody3D):
	if active:
		transition.emit("Transform")

func timeout():
	if active:
		transition.emit("WalkTowards")
