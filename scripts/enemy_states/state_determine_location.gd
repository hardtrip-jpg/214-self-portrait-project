extends EnemyBaseState
class_name DetermineLocationState

func extra_ready():
	area.body_entered.connect(body_enter)

func enter(_previous_state) -> void:
	animation.play("stalk_idle")
	randomize()
	enemy.nav_agent.target_position = enemy.positions.pick_random().global_position
	
	print(enemy.current_target)
	transition.emit("Wait")

func body_enter(body : CharacterBody3D):
	if active:
		transition.emit("Transform")
