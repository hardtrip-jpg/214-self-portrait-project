extends State
class_name PlayerMovementState

var PLAYER: PlayerController
var ANIMATION: AnimationPlayer

func _ready() -> void:
	await owner.ready
	PLAYER = owner as PlayerController
	ANIMATION = PLAYER.ANIMATION_PLAYER
