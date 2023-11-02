
extends PlayerState

var jump_time: float

func enter(msg: Dictionary = {}) -> void:
	pass
	jump_time = Globals.PLAYER_JUMP_TIME
#	body.floor_snap_length = Player.FLOOR_SNAP_DISABLED

func physics_update(delta: float) -> void:
#	if(body.is_on_floor()):
#		transition_to(PlayerState.ON_GROUND)
#		return
		
	if(Input.is_action_just_released(InputHandler.JUMP) || jump_time <= 0):
		transition_to(PlayerState.IN_AIR)
		return

	body.velocity.y += player.jump_height * 10 * delta
	jump_time -= delta
	
	player.process_movement()
