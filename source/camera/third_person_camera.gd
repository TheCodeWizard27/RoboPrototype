
class_name ThirdPersonCamera
extends SpringArm3D

@export_range(0, 1) var mouse_sensitivity: float = 0.2

@export var current: bool = false: 
	set(value):
		_current = value
		if(_camera):
			_camera.current = value
	get:
		return _camera.current if _camera else _current

@onready var _camera = $Camera3D

var _current = false

func _ready():
	_camera.current = _current
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if(not $Camera3D.current):
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
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 30)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
