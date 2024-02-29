extends Node3D
signal terminated
signal escaped
var subject_active = true

const MODULE_BUTTON = preload("res://Module Components/module_button.tscn")
const MODULE_INDICATOR_LIGHT = preload("res://Module Components/module_indicator_light.tscn")
var HALLWAY_LIGHT_BOX_SHAPE = BoxMesh.new()
const GRID_PADDING = 0.02
const GRID_SIZE = 6

@onready var module_base = $ModuleBase
@onready var door_btns = $DoorBtns
@onready var hallway_lights = $HallwayLights

var MINOTAUR_POSITION := Vector2i(2, 3)
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
		"neighbors": [Vector2i(4, 1), Vector2i(5, 0)],
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
		"neighbors": [Vector2i(4, 3), Vector2i(3, 4), Vector2i(5, 4)],
		#"light": $HallwayLights/ModuleIndicatorLight
	},
	{
		"pos": Vector2i(2, 1),
		"neighbors": [Vector2i(2, 2), Vector2i(2, 0)],
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
		"neighbors": [Vector2i(2, 5), Vector2i(0, 5)],
		#"light": $HallwayLights/ModuleIndicatorLight5
	},
]


func _ready():
	HALLWAY_LIGHT_BOX_SHAPE.size = Vector3(0.05, 0.05, 0.05)
	
	setup_door_btns()
	init_hallway_lights()

func _process(_delta):
	display_minotaur()


func _on_subject_movement_timeout():
	if subject_active:
		var target_door = pathfind_to_nearest_open_door()
		if !target_door:
			printerr("No doors available!")
			emit_signal("escaped")
			subject_active = false
			return
		
		var current_cell = target_door
		var old_cell
		while(current_cell.has("parent")):
			old_cell = current_cell
			current_cell = get_cell_from_pos(current_cell.parent)
		
		
		MINOTAUR_POSITION = old_cell.pos
		
		check_if_escaped()

func pathfind_to_nearest_open_door() -> Dictionary:
	for hall_loc in HALLWAY_LOCATIONS:
		hall_loc.erase("parent")
	for door_loc in DOOR_LOCATIONS:
		door_loc.erase("parent")
	
	var frontier = [get_cell_from_pos(MINOTAUR_POSITION)]
	var explored = [get_cell_from_pos(MINOTAUR_POSITION)]
	
	#Ignore closed doors
	for door_loc in DOOR_LOCATIONS:
		if door_loc.has("door") and !door_loc.door.is_toggled:
			explored.append(door_loc)
	
	
	while(frontier.size() > 0):
		var current_cell = frontier.pop_front()
		
		if current_cell in DOOR_LOCATIONS and current_cell.has("door") and current_cell.door.is_toggled:
			return current_cell
		
		if current_cell in HALLWAY_LOCATIONS:
			for neighbor_pos in current_cell.neighbors:
				var neighbor = get_cell_from_pos(neighbor_pos)
				if !explored.has(neighbor):
					explored.append(neighbor)
					frontier.append(neighbor)
					neighbor.parent = current_cell.pos
	return {}

func get_cell_from_pos(pos: Vector2i) -> Dictionary:
	for hall_loc in HALLWAY_LOCATIONS:
		if hall_loc.pos == pos:
			return hall_loc
	for door_loc in DOOR_LOCATIONS:
		if door_loc.pos == pos:
			return door_loc
	printerr("No such cell at pos " + str(pos))
	return {}

func check_if_escaped() -> void:
	for door_loc in DOOR_LOCATIONS:
		if MINOTAUR_POSITION == door_loc.pos:
			emit_signal("escaped")
			subject_active = false

func display_minotaur() -> void:
	for indicator_light in hallway_lights.get_children():
		indicator_light.set_state(false)
	
	if subject_active:
		for pos: Dictionary in HALLWAY_LOCATIONS:
			if pos.pos == MINOTAUR_POSITION:
				if pos.has("light") and pos.light:
					pos.light.set_state(true)

func setup_door_btns() -> void:
	for door_loc in DOOR_LOCATIONS:
		var door = MODULE_BUTTON.instantiate()
		door.toggle_mode = true
		door.get_node("MeshInstance3D").mesh = HALLWAY_LIGHT_BOX_SHAPE
		door_btns.add_child(door)
		position_grid_element(door, door_loc)
		#door.connect("pressed", door_btn_pressed)
		#door.connect("unpressed", door_btn_unpressed)
		
		door.press()
		
		door_loc.door = door

func init_hallway_lights() -> void:
	for hall_loc in HALLWAY_LOCATIONS:
		var light = MODULE_INDICATOR_LIGHT.instantiate()
		light.mesh = HALLWAY_LIGHT_BOX_SHAPE
		hallway_lights.add_child(light)
		position_grid_element(light, hall_loc)
		hall_loc.light = light
	
	#Setup Neighbors (the old method was shit)
	var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	for hall_loc in HALLWAY_LOCATIONS:
		hall_loc.neighbors = []
		
		for direction in directions:
				var neighbor_pos = hall_loc.pos + direction
				if neighbor_pos.x < 0 or neighbor_pos.y < 0 or neighbor_pos.x >= GRID_SIZE or neighbor_pos.y >= GRID_SIZE:
					continue
				
				for n_loc_i in range(HALLWAY_LOCATIONS.size()):
					if HALLWAY_LOCATIONS[n_loc_i].pos == neighbor_pos:
						hall_loc.neighbors.append(neighbor_pos)
				for n_loc_i in range(DOOR_LOCATIONS.size()):
					if DOOR_LOCATIONS[n_loc_i].pos == neighbor_pos:
						hall_loc.neighbors.append(neighbor_pos)

func position_grid_element(grid_element, loc) -> void:
	grid_element.position.x -= module_base.mesh.size.x / 2.0 - HALLWAY_LIGHT_BOX_SHAPE.size.x / 2.0 - GRID_PADDING
	grid_element.position.y += module_base.mesh.size.y / 2.0 - HALLWAY_LIGHT_BOX_SHAPE.size.z / 2.0 - GRID_PADDING
	
	grid_element.position.x += loc.pos.x * ((module_base.mesh.size.x - GRID_PADDING) / float(GRID_SIZE))
	grid_element.position.y -= loc.pos.y * ((module_base.mesh.size.y - GRID_PADDING) / float(GRID_SIZE))
