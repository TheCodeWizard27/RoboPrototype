
extends PlayerState

var jump_time: float
var max_jump_time: float

var _initial_velocity: Vector2

func enter(msg: Dictionary = {}) -> void:
	jump_time = 0
	max_jump_time = Globals.PLAYER_JUMP_TIME
	_initial_velocity = Vector2(player._body.velocity.x, player._body.velocity.z)
#	body.floor_snap_length = Player.FLOOR_SNAP_DISABLED

func physics_update(delta: float) -> void:
	jump_time += delta
	
	if(Input.is_action_just_released(InputHandler.JUMP) || jump_time >= max_jump_time):
		transition_to(PlayerState.IN_AIR)
		return

	var relative_time = jump_time / max_jump_time 
	
	var jumpStrength = Bezier.cubicf(
		player.jump_height,
		Vector2(0,1),
		Vector2(0,1),
		player.jump_height, relative_time)
	
	print_debug("JumpStrength:", jumpStrength)
	
	body.velocity.y = jumpStrength
	
	player.process_movement(delta)
	
	player._body.velocity.x += _initial_velocity.x
	player._body.velocity.z += _initial_velocity.y
