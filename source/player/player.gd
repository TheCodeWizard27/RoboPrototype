
class_name Player
extends Node3D

const FLOOR_SNAP_ENABLED: float = 1
const FLOOR_SNAP_DISABLED: float = 0

@export var speed: float = Globals.PLAYER_SPEED
@export var jump_speed: float = Globals.PLAYER_JUMP_HEIGHT
@export var turn_threshold: float = 0.2

@export var camera_mount: Node3D

@onready var _body: CharacterBody3D = $'Body'
@onready var _state_machine: StateMachine = $'StateMachine'

func _ready():
	_body.floor_snap_length = FLOOR_SNAP_ENABLED

func _process(delta: float):
	camera_mount.update_position(_body.global_position)
	_state_machine.process(delta)

func _physics_process(delta: float):
	_calc_movement(delta)
	_state_machine.physics_process(delta)
	
func _unhandled_key_input(event: InputEvent):
	var defaultBody: CollisionShape3D = $Body/DefaultBody
	var smallBody: CollisionShape3D = $Body/SmallBody
	
	if(event.keycode == KEY_F):
		defaultBody.disabled = true
		smallBody.disabled = false
		
		for node in defaultBody.get_children():
			node.visible = false
		
		for node in smallBody.get_children():
			node.visible = true
	if(event.keycode == KEY_R):
		defaultBody.disabled = false
		smallBody.disabled = true
		
		for node in defaultBody.get_children():
			node.visible = true
		
		for node in smallBody.get_children():
			node.visible = false

func _calc_movement(delta: float) -> void:
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength(InputHandler.RIGHT) - Input.get_action_strength(InputHandler.LEFT)
	move_dir.z = Input.get_action_strength(InputHandler.DOWN) - Input.get_action_strength(InputHandler.UP)
	move_dir = move_dir.rotated(Vector3.UP, camera_mount.rotation.y).normalized()
	
	_body.velocity.x = move_dir.x * speed
	_body.velocity.z = move_dir.z * speed
	_body.velocity.y -= Globals.GRAVITY * delta
	
	var landed := _body.is_on_floor() and _body.floor_snap_length == FLOOR_SNAP_DISABLED
	var jumping := _body.is_on_floor() and Input.is_action_just_pressed(InputHandler.JUMP)
	
	if(jumping):
		_body.velocity.y = jump_speed
		_body.floor_snap_length = FLOOR_SNAP_DISABLED
	elif(landed):
		_body.floor_snap_length = FLOOR_SNAP_ENABLED
	
	_body.move_and_slide()
	
	if(_body.velocity.length() > turn_threshold):
		_body.rotation.y = Vector2(_body.velocity.z, _body.velocity.x).angle()
