
extends PlayerState

var jump_time: float
var max_jump_time: float

func enter(msg: Dictionary = {}) -> void:
	jump_time = 0
	max_jump_time = Globals.PLAYER_JUMP_TIME
#	body.floor_snap_length = Player.FLOOR_SNAP_DISABLED

func physics_update(delta: float) -> void:
#	if(body.is_on_floor()):
#		transition_to(PlayerState.ON_GROUND)
#		return
		
	jump_time += delta
		
	if(Input.is_action_just_released(InputHandler.JUMP) || jump_time >= max_jump_time):
		transition_to(PlayerState.IN_AIR)
		return

	var relative_time = jump_time / max_jump_time 
	# TODO Cleanup
	var jumpStrength = Bezier.cubic_f(
		player.jump_height * 0.5,
		Vector2(0,1),
		Vector2(0,1),
		player.jump_height, relative_time)
	
	print_debug("JumpStrength:", jumpStrength)
	
	body.velocity.y = jumpStrength
	
	player.process_movement()
