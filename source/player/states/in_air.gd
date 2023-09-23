
extends PlayerState

func physics_update(delta: float) -> void:
	
	if(body.is_on_floor()):
		transition_to(PlayerState.ON_GROUND)
