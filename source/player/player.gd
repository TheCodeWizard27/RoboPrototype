
class_name Player
extends Node3D

const FLOOR_SNAP_ENABLED: float = 1
const FLOOR_SNAP_DISABLED: float = 0

@export var speed: float = Globals.PLAYER_SPEED
@export var jump_height: float = Globals.PLAYER_JUMP_HEIGHT
@export var turn_threshold: float = 0.2

@export var camera_mount: Node3D

@onready var _body: CharacterBody3D = $'Body'
@onready var _state_machine: StateMachine = $'StateMachine'
@onready var _animation_player: AnimationPlayer = $'Body/TestModel/AnimationPlayer'

func _ready():
	_body.floor_snap_length = FLOOR_SNAP_ENABLED
	
	_animation_player.current_animation = "Idle"
	_animation_player.connect("animation_finished", _on_animation_finished)

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

func reset_position(position: Vector3) -> void:
	_body.position = position

func process_movement(delta: float, speed_modifier: float = 1):
	
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength(InputHandler.RIGHT) - Input.get_action_strength(InputHandler.LEFT)
	move_dir.z = Input.get_action_strength(InputHandler.DOWN) - Input.get_action_strength(InputHandler.UP)
	move_dir = move_dir.rotated(Vector3.UP, camera_mount.rotation.y).normalized()
	
	# TODO Clean this up!
	if((abs(move_dir.x) > 0.1 || abs(move_dir.z) > 0.1) && _animation_player.current_animation == "Idle"):
		_animation_player.play("Walk", 0, 10)
	
	var x_speed = move_dir.x * speed * speed_modifier
	var z_speed = move_dir.z * speed * speed_modifier
	
	_body.velocity.x = lerpf(_body.velocity.x, min(x_speed, speed), 1)
	_body.velocity.z = lerpf(_body.velocity.z, min(z_speed, speed), 1)

func _process_physics(delta: float) -> void:
	_body.move_and_slide()
	
	var movement = Vector2(_body.velocity.x, _body.velocity.z)
	
	if(movement.length() > turn_threshold):
		var target = Quaternion(Vector3.UP, Vector2(_body.velocity.z, _body.velocity.x).angle())
		_body.basis = _body.basis.slerp(target, 0.2)
		
func _on_animation_finished(animation: String) -> void:
	if(animation == "Walk"):
		_animation_player.play("Idle")
