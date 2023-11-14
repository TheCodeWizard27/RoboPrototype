
class_name PlayerState
extends State

@export var body: CharacterBody3D
@export var player: Player

const IN_AIR: NodePath = ^'InAir'
const ON_GROUND: NodePath = ^'OnGround'
const JUMPING: NodePath = ^'Jumping'
