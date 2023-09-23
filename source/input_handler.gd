
extends Node

const UP := "UP"
const DOWN := "DOWN"
const LEFT := "LEFT"
const RIGHT := "RIGHT"

const JUMP := "JUMP"

# TODO find a way to maybe have a clean configuration for these.
var mouse_sensitivity = 0.2

func _ready():
	print_debug("input_handler.gd: Initialising Custom Input Map")
	# TODO do this in a clean way someday
