extends Node3D
signal terminated
signal escaped
var subject_active = true

const MODULE_BUTTON = preload("res://Module Components/module_button.tscn")
const MODULE_INDICATOR_LIGHT = preload("res://Module Components/module_indicator_light.tscn")
var HALLWAY_LIGHT_BOX_SHAPE = BoxMesh.new()
const GRID_PADDING = 0.02

@onready var module_base = $ModuleBase
@onready var door_btns = $DoorBtns
@onready var hallway_lights = $HallwayLights

var MINOTAUR_POSITION = Vector2i(2, 3)
var DOOR_LOCATIONS = [
	{
		"pos": Vector2i(2, 0)
	},
	{
		"pos": Vector2i(5, 0)
	},
	{
		"pos": Vector2i(5, 4)
	},
	{
		"pos": Vector2i(0, 5)
	}
]
var HALLWAY_LOCATIONS = [
	{
		"pos": Vector2i(4, 0),
		"neighbors": [Vector2i(4, 1)],
		#"light": $HallwayLights/ModuleIndicatorLight12
	},
	{
		"pos": Vector2i(4, 1),
		"neighbors": [Vector2i(4, 0), Vector2i(4, 2)],
		#"light": $HallwayLights/ModuleIndicatorLight11
	},
	{
		"pos": Vector2i(4, 2),
		"neighbors": [Vector2i(4, 3), Vector2i(3, 2)],
		#"light": $HallwayLights/ModuleIndicatorLight10
	},
	{
		"pos": Vector2i(4, 3),
		"neighbors": [Vector2i(4, 2), Vector2i(4, 4)],
		#"light": $HallwayLights/ModuleIndicatorLight13
	},
	{
		"pos": Vector2i(4, 4),
		"neighbors": [Vector2i(4, 3), Vector2i(3, 4)],
		#"light": $HallwayLights/ModuleIndicatorLight
	},
	{
		"pos": Vector2i(2, 1),
		"neighbors": [Vector2i(2, 2)],
		#"light": $HallwayLights/ModuleIndicatorLight8
	},
	{
		"pos": Vector2i(2, 2),
		"neighbors": [Vector2i(2, 1), Vector2i(3, 2)],
		#"light": $HallwayLights/ModuleIndicatorLight7
	},
	{
		"pos": Vector2i(2, 3),
		"neighbors": [Vector2i(2, 2), Vector2i(2, 4)],
		#"light": $HallwayLights/ModuleIndicatorLight6
	},
	{
		"pos": Vector2i(2, 4),
		"neighbors": [Vector2i(2, 3), Vector2i(2, 5), Vector2i(3, 4)],
		#"light": $HallwayLights/ModuleIndicatorLight3
	},
	{
		"pos": Vector2i(2, 5),
		"neighbors": [Vector2i(2, 4), Vector2i(1, 5)],
		#"light": $HallwayLights/ModuleIndicatorLight4
	},
	{
		"pos": Vector2i(3, 2),
		"neighbors": [Vector2i(2, 2), Vector2i(4, 2)],
		#"light": $HallwayLights/ModuleIndicatorLight9
	},
	{
		"pos": Vector2i(3, 4),
		"neighbors": [Vector2i(2, 4), Vector2i(4, 4)],
		#"light": $HallwayLights/ModuleIndicatorLight2
	},
	{
		"pos": Vector2i(1, 5),
		"neighbors": [Vector2i(2, 5)],
		#"light": $HallwayLights/ModuleIndicatorLight5
	},
]

func _ready():
	HALLWAY_LIGHT_BOX_SHAPE.size = Vector3(0.05, 0.01, 0.05)
	
	init_hallway_lights()
	setup_door_btns()

func _process(_delta):
	if subject_active:
		display_minotaur()


func door_btn_pressed(btn: StaticBody3D) -> void:
	if subject_active:
		print(btn.name)


func _on_subject_movement_timeout():
	if subject_active:
		var neighbors = []
		for hall_loc in HALLWAY_LOCATIONS:
			if hall_loc.pos == MINOTAUR_POSITION:
				print(hall_loc)
				neighbors = hall_loc.neighbors
		if neighbors.size() < 1:
			printerr("No Neighbors!")
			return
		
		MINOTAUR_POSITION = neighbors[randi_range(0, neighbors.size() - 1)]

func display_minotaur() -> void:
	for indicator_light in hallway_lights.get_children():
		indicator_light.set_state(false)
	for pos: Dictionary in HALLWAY_LOCATIONS:
		if pos.pos == MINOTAUR_POSITION:
			if pos.has("light") and pos.light:
				pos.light.set_state(true)

func setup_door_btns() -> void:
	for door_loc in DOOR_LOCATIONS:
		var door = MODULE_BUTTON.instantiate()
		door.get_node("MeshInstance3D").mesh = HALLWAY_LIGHT_BOX_SHAPE
		door_btns.add_child(door)
		position_grid_element(door, door_loc)
		door.connect("pressed", door_btn_pressed)

func init_hallway_lights() -> void:
	for hall_loc in HALLWAY_LOCATIONS:
		var light = MODULE_INDICATOR_LIGHT.instantiate()
		light.mesh = HALLWAY_LIGHT_BOX_SHAPE
		hallway_lights.add_child(light)
		position_grid_element(light, hall_loc)
		hall_loc.light = light

func position_grid_element(grid_element, loc) -> void:
	grid_element.position.x -= module_base.mesh.size.x / 2.0 - HALLWAY_LIGHT_BOX_SHAPE.size.x / 2.0 - GRID_PADDING
	grid_element.position.y += module_base.mesh.size.y / 2.0 - HALLWAY_LIGHT_BOX_SHAPE.size.z / 2.0 - GRID_PADDING
	
	grid_element.position.x += loc.pos.x * ((module_base.mesh.size.x - GRID_PADDING) / 6.0)
	grid_element.position.y -= loc.pos.y * ((module_base.mesh.size.y - GRID_PADDING) / 6.0)
