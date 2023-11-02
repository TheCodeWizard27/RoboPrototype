
extends PlayerState

func enter(msg: Dictionary = {}) -> void:
	pass
#	var landed := body.is_on_floor() and body.floor_snap_length == Player.FLOOR_SNAP_DISABLED
#
#	if(landed):
#		body.floor_snap_length = Player.FLOOR_SNAP_ENABLED

func physics_update(delta: float) -> void:
	
	if(not body.is_on_floor()):
		transition_to(PlayerState.IN_AIR)
		return
	
	if(Input.is_action_just_pressed(InputHandler.JUMP)):
		transition_to(PlayerState.JUMPING)
		return
	
	player.process_movement()
	
