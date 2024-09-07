extends State
class_name EnemyBaseState

var player : PlayerController
var animation : AnimationPlayer
var enemy : Enemy
var area : Area3D

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	animation = enemy.animation
	player = Global.player
	area = enemy.area
	extra_ready()

func extra_ready() -> void:
	pass
