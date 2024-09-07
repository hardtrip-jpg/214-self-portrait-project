extends EnemyBaseState
class_name DetermineLocationState

@export var sound : AudioStream

func extra_ready():
	area.body_entered.connect(body_enter)

func enter(_previous_state) -> void:
	if audio_voice.stream != sound:
		audio_voice.stream = sound
		audio_voice.play()
	animation.play("stalk_idle")
	randomize()
	enemy.nav_agent.target_position = enemy.positions.pick_random().global_position
	enemy.current_target = enemy.nav_agent.get_final_position()
	
func update(_delta):
	transition.emit("Wait")

func body_enter(body : CharacterBody3D):
	if active:
		transition.emit("Transform")
