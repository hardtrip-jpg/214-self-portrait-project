extends Control
class_name FadeUI

@export var TIMER : Timer
@export var FADE_WEIGHT : int = 10

var timer_bool : bool = false
var is_fading : bool = false
var faded : bool = false

func _ready():
	modulate.a8 = 0
	TIMER.timeout.connect(timeout)

func _physics_process(_delta):
	if is_fading:
		if modulate.a8 == 0:
			faded = true
			is_fading = false
		else:
			modulate.a8 -= FADE_WEIGHT

func start_fading():
	if !is_fading:
		TIMER.start()
		timer_bool = true

func stop_fading():
	is_fading = false
	faded = false
	modulate.a8 = 1000
	TIMER.stop()

func timeout():
	is_fading = true
	timer_bool = false
