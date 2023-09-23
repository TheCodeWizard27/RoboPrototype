
class_name Player
extends Node3D

@export var speed: float = Globals.PLAYER_SPEED
@export var jump_speed: float = Globals.PLAYER_JUMP_HEIGHT
@export var turn_threshold: float = 0.2

# TODO theres 100% a better way to clean up this dependency
@export var camera_mount: Node3D

var _snap_vector: Vector3 = Vector3.DOWN

@onready var _body: CharacterBody3D = $'Body'
@onready var _state_machine: StateMachine = $'StateMachine'

func _process(delta: float):
	camera_mount.global_position = _body.global_position
	
	_state_machine.process(delta)

func _physics_process(delta: float):

	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength(InputHandler.RIGHT) - Input.get_action_strength(InputHandler.LEFT)
	move_dir.z = Input.get_action_strength(InputHandler.DOWN) - Input.get_action_strength(InputHandler.UP)
	move_dir = move_dir.rotated(Vector3.UP, camera_mount.rotation.y).normalized()
	
	_body.velocity.x = move_dir.x * speed
	_body.velocity.z = move_dir.z * speed
	_body.velocity.y -= Globals.GRAVITY * delta
	
	var landed := _body.is_on_floor() and _snap_vector == Vector3.ZERO
	var jumping := _body.is_on_floor() and Input.is_action_just_pressed(InputHandler.JUMP)
	
	if(jumping):
		_body.velocity.y = jump_speed
		_snap_vector = Vector3.ZERO
	elif(landed):
		_snap_vector = Vector3.DOWN
	
	_body.move_and_slide()
	
	if(_body.velocity.length() > turn_threshold):
		_body.rotation.y = Vector2(_body.velocity.z, _body.velocity.x).angle()
	
	_state_machine.physics_process(delta)
	
	
