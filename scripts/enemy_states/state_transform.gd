extends EnemyBaseState
class_name TransformState

@export var sound : AudioStream

func enter(_previous_state) -> void:
	animation.play("state_change")
	audio_voice.stop()
	audio_voice.stream = sound
	audio_voice.play()
	await animation.animation_finished
	transition.emit("Crawl")
