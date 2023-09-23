
extends PlayerState

func physics_update(delta: float) -> void:
	
	if(not body.is_on_floor()):
		transition_to(PlayerState.IN_AIR)
	
