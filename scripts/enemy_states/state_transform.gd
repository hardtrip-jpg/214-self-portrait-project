extends EnemyBaseState
class_name TransformState

func enter(_previous_state) -> void:
	animation.play("state_change")
	await animation.animation_finished
	transition.emit("Crawl")
