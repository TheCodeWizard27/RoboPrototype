
class_name CameraBase
extends Node3D

@export_range(0, 1) var mouse_sensitivity: float = 0.2

@export var current: bool = false: 
	set(value):
		_current = value
		if(Camera):
			Camera.current = value
	get:
		return Camera.current if Camera else _current

@onready var Camera: Camera3D

var _current = false

func init() -> void:
	pass

func _ready():
	init()
	assert(Camera, "Camera must be set defined!")
	
	Camera.current = _current
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update_position(position: Vector3) -> void:
	global_position.y = lerpf(global_position.y, position.y, 0.5)
	global_position.x = position.x
	global_position.z = position.z
#	global_position = position

func _unhandled_input(event: InputEvent) -> void:
	if(not current):
		return
	
	if(event.is_action("click")):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if(event.is_action_pressed("toggle_mouse_captured")):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if(event is InputEventMouseMotion):
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = lerpf(rotation_degrees.x, clamp(rotation_degrees.x, -90, 30), 1)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = lerpf(rotation_degrees.y, wrapf(rotation_degrees.y, 0, 360), 1)

