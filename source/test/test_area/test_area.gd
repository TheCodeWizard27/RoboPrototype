extends Node3D


@onready var _player: Player = $Player
@onready var _fps_camera: CameraBase = $FirstPersonCamera
@onready var _tp_camera: CameraBase = $ThirdPersonCamera
@onready var _start_pos: Marker3D = $StartPos

func _unhandled_key_input(event: InputEvent):
	if(event.keycode == KEY_1):
		_player.camera_mount = _fps_camera
		_tp_camera.current = false
		_fps_camera.current = true
	elif(event.keycode == KEY_2):
		_player.camera_mount = _tp_camera
		_fps_camera.current = false
		_tp_camera.current = true
		
	if(event.keycode == KEY_G):
		_player.reset_position(_start_pos.position)
