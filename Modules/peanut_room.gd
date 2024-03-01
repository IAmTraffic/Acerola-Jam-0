extends Node3D

@onready var peanut_room = $peanut_room
@onready var peanut = $Peanut

const PEANUT_MOVEMET_BOUNDS_RADIUS = 4.0

func _ready():
	for child in peanut_room.get_children():
		if child is MeshInstance3D:
			child.layers = 2

func random_move_peanut():
	peanut.position.x = randf_range(-PEANUT_MOVEMET_BOUNDS_RADIUS, PEANUT_MOVEMET_BOUNDS_RADIUS)
	peanut.position.z = randf_range(-PEANUT_MOVEMET_BOUNDS_RADIUS, PEANUT_MOVEMET_BOUNDS_RADIUS)
