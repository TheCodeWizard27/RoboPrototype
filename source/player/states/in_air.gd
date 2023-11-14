
extends PlayerState

func physics_update(delta: float) -> void:
	
	body.velocity.y -= Globals.GRAVITY * 2 * delta
	
	if(body.is_on_floor()):
		transition_to(PlayerState.ON_GROUND)
		return
		
	player.process_movement(delta, 0.5)
