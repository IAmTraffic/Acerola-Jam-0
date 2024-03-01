extends Node3D

const CLICK_RAY_LENGTH = 10

var MODULES = [[null, null, null, null], [null, null, null, null]]
const BASE_MODULE_POSITION = Vector2(-0.75, 1.75)
const DELTA_MODULE_POSITION = Vector2(0.5, -0.5)

@onready var module_wrapper = $ModuleWrapper
@onready var camera = $Camera3D

@onready var ui_label = %UILabel


#Module Types
const INDESTRUCTIBLE_LIZARD_MODULE = preload("res://Modules/indestructible_lizard.tscn")
const LONESOME_GEORGE_MODULE = preload("res://Modules/lonesome_george.tscn")
const MINOTAUR_MODULE = preload("res://Modules/minotaur.tscn")
const PEANUT_MODULE = preload("res://Modules/peanut.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(event):
	#Handle clicking on things
	if event is InputEventMouseButton:
		var result = get_mouse_target(event)
		
		if result and result.collider.has_method("press"):
				result.collider.press(event.pressed, event.button_index)
			#match result.collider.collision_layer:
				#1:
					#if result.collider.has_method("press"):
						#result.collider.press()
				#_:
					#printerr("Bad collision layer " + str(result.collider.collision_layer) + " on collider " + result.collider.name)
	
	
	#Handle the mouseover for diagetic UI
	if event is InputEventMouseMotion:
		ui_label.position = event.position - Vector2(ui_label.get_minimum_size().x / 2, ui_label.get_minimum_size().y)
		
		var result = get_mouse_target(event)
		if result and result.has("collider"):
			ui_label.show()
			ui_label.text = result.collider.name
			#match result.collider.name:
				#"Handbook":
					#ui_label.show()
					#ui_label.text = "Handbook"
				#_:
					#ui_label.show()
					#ui_label.text = "ERROR: Bad Collider Name"
		else:
			ui_label.hide()
			ui_label.text = "should never be seen"

func get_mouse_target(event: InputEvent) -> Dictionary:
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * CLICK_RAY_LENGTH
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	return space_state.intersect_ray(query)

#func _ready():
	#spawn_module(Vector2i(0, 0), INDESTRUCTIBLE_LIZARD_MODULE)
	#spawn_module(Vector2i(1, 0), LONESOME_GEORGE_MODULE)
	#spawn_module(Vector2i(2, 0), MINOTAUR_MODULE)
	#spawn_module(Vector2i(3, 0), PEANUT_MODULE)

func spawn_module(location: Vector2i, module: PackedScene) -> void:
	if location.y >= MODULES.size() or location.x >= MODULES[location.y].size():
		printerr("Bad location " + str(location.x) + ", " + str(location.y))
		return
	
	var new_module = module.instantiate()
	module_wrapper.add_child(new_module)
	new_module.position = Vector3(BASE_MODULE_POSITION.x + DELTA_MODULE_POSITION.x * location.x, BASE_MODULE_POSITION.y + DELTA_MODULE_POSITION.y * location.y, -0.5)
	new_module.connect("terminated", module_terminated)
	new_module.connect("escaped", module_escaped)

func module_terminated() -> void:
	module_failed("Terminated")
func module_escaped() -> void:
	module_failed("Escaped")

func module_failed(failure_reason: String) -> void:
	print("Module Failed! " + failure_reason)
