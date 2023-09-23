
class_name State
extends Node

signal transitioned_to(target_state_path: NodePath, msg: Dictionary)
signal transitioned_back(msg: Dictionary)

func transition_to(target_state_path: NodePath, msg: Dictionary = {}) -> void:
	transitioned_to.emit(target_state_path, msg)

func transition_back(msg: Dictionary = {}) -> void:
	transitioned_back.emit(msg)

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
	
func enter(msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass
