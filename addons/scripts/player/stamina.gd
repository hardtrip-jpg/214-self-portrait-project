extends Node
class_name StaminaController

@export var UI : FadeUI
@onready var TIMER : Timer = %StaminaTimer

var value : float = 100.0 : set = set_value
var can_refill : bool = true

func _ready():
	Global.stamina = self
	TIMER.timeout.connect(timeout)

func _physics_process(delta):
	if can_refill:
		value += 0.5
	
	UI.value = lerpf(UI.value, value, delta * 10)
	

func set_value(new_value : float):
	if UI.is_fading or UI.faded or UI.timer_bool:
		UI.stop_fading()
	
	if new_value >= 100:
		can_refill = false
		value = 100
		UI.start_fading()
		return
	elif new_value < value:
		value = new_value
		can_refill = false
		TIMER.start()
	else:
		value = new_value

func timeout():
	can_refill = true
