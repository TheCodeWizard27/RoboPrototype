
class_name ThirdPersonCamera
extends SpringArm3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action("click")):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if(event.is_action_pressed("toggle_mouse_captured")):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if(event is InputEventMouseMotion):
		rotation_degrees.x -= event.relative.y * 0.2
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 30)
		
		rotation_degrees.y -= event.relative.x * 0.2
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
