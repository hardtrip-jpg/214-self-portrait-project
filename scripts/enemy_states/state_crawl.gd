extends EnemyBaseState
class_name CrawlState

@export var speed : float = 1
@export var sound : AudioStream

func enter(_previous_state) -> void:
	animation.play("crawl")
	audio_voice.stream = sound
	audio_voice.play()
	

func update(_delta : float):
	enemy.get_new_pos(_delta)

func physics_update(_delta : float) -> void:
	enemy.move(_delta, speed)
	enemy.nav_agent.target_position = player.global_position
