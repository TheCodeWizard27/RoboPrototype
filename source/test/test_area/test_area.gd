extends Node3D


@onready var _player: Player = $Player
@onready var _fpsCamera: Camera3D = $FirstPesonCamera
@onready var _tpCamera: SpringArm3D = $ThirdPersonCamera

func _unhandled_key_input(event: InputEvent):
	if(event.keycode == KEY_1):
		_player.camera_mount = _fpsCamera
		_tpCamera.current = false
		_fpsCamera.current = true
	elif(event.keycode == KEY_2):
		_player.camera_mount = _tpCamera
		_fpsCamera.current = false
		_tpCamera.current = true
