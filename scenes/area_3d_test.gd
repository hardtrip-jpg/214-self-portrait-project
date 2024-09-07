extends Area3D

func _ready():
	body_entered.connect(body_enter)

func body_enter(body : CharacterBody3D):
	print("entered")
