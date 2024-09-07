extends Node
class_name State

signal transition(new_state_name: StringName)
var active : bool = false

func enter(_previous_state) -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
