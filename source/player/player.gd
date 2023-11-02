
class_name Player
extends Node3D

const FLOOR_SNAP_ENABLED: float = 1
const FLOOR_SNAP_DISABLED: float = 0

@export var speed: float = Globals.PLAYER_SPEED
@export var jump_height: float = Globals.PLAYER_JUMP_STRENGTH
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
	_state_machine.physics_process(delta)
	_process_physics(delta)
	
func _unhandled_key_input(event: InputEvent):
	var defaultBody: CollisionShape3D = $Body/DefaultBody
	var smallBody: CollisionShape3D = $Body/SmallBody
	
	if(event.keycode == KEY_R && event.is_pressed()):
		defaultBody.disabled = !defaultBody.disabled
		smallBody.disabled = !smallBody.disabled
		
		for node in defaultBody.get_children():
			node.visible = !node.visible
		
		for node in smallBody.get_children():
			node.visible = !node.visible

func process_movement():
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength(InputHandler.RIGHT) - Input.get_action_strength(InputHandler.LEFT)
	move_dir.z = Input.get_action_strength(InputHandler.DOWN) - Input.get_action_strength(InputHandler.UP)
	move_dir = move_dir.rotated(Vector3.UP, camera_mount.rotation.y).normalized()
	
	_body.velocity.x = move_dir.x * speed
	_body.velocity.z = move_dir.z * speed

func _process_physics(delta: float) -> void:
	_body.velocity.y -= Globals.GRAVITY * 5 * delta
	
	_body.move_and_slide()
	
	if(_body.velocity.length() > turn_threshold):
		_body.rotation.y = Vector2(_body.velocity.z, _body.velocity.x).angle()
