extends Node3D

const CLICK_RAY_LENGTH = 10

var MODULES = [[null, null, null, null], [null, null, null, null]]
const BASE_MODULE_POSITION = Vector2(-0.75, 1.75)
const DELTA_MODULE_POSITION = Vector2(0.5, -0.5)

@onready var module_wrapper = $ModuleWrapper
@onready var camera = $Camera3D
@onready var ui_label = %UILabel
@onready var punch_clock = %"Punch Clock"
@onready var inbox = %"In Box"
@onready var desk_items_wrapper = %DeskItemsWrapper
@onready var post_shift_review = %PostShiftReview


var shift_active := false

var SHIFT_LIST := []

var shift_failures := {}

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
	
	#Handle the mouseover for diagetic UI
	if event is InputEventMouseMotion:
		ui_label.position = event.position - Vector2(ui_label.get_minimum_size().x / 2, ui_label.get_minimum_size().y)
		
		var result = get_mouse_target(event)
		if result and result.has("collider"):
			ui_label.show()
			ui_label.text = result.collider.name
		else:
			ui_label.hide()
			ui_label.text = "should never be seen"

func get_mouse_target(event: InputEvent) -> Dictionary:
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * CLICK_RAY_LENGTH
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	return space_state.intersect_ray(query)

func _ready():
	load_shift_list()
	
	punch_clock.connect("pressed", on_punch_clock_pressed)
	inbox.connect("inbox_cleared", on_inbox_cleared)
	
	inbox.process_mode = Node.PROCESS_MODE_DISABLED
	#post_shift_review.hide()

func on_inbox_cleared(num_mistakes):
	shift_failures.mail_mistakes = num_mistakes
	cleanup_shift()
	
	post_shift_review.show()
	#desk_items_wrapper.process_mode = Node.PROCESS_MODE_DISABLED

func load_shift_list() -> void:
	var file = FileAccess.open("res://Assets/shifts.json", FileAccess.READ)
	
	var json = JSON.parse_string(file.get_as_text())
	
	for shift in json:
		var new_shift = {}
		new_shift.inbox_count = shift.inbox_count
		new_shift.modules = []
		for module in shift.modules:
			match module:
				"GRG":
					new_shift.modules.append(LONESOME_GEORGE_MODULE)
				"HIL":
					new_shift.modules.append(INDESTRUCTIBLE_LIZARD_MODULE)
				"CR3":
					new_shift.modules.append(MINOTAUR_MODULE)
				"173":
					new_shift.modules.append(PEANUT_MODULE)
				_:
					printerr("Bad Module " + str(module))
		SHIFT_LIST.append(new_shift)
	
	
	file.close()

func on_punch_clock_pressed(_clock):
	if !shift_active:
		shift_active = true
		setup_shift()

func setup_shift() -> void:
	inbox.process_mode = Node.PROCESS_MODE_INHERIT
	
	var shift = SHIFT_LIST.pop_front()
	shift_failures = {
		"terminations": 0,
		"escapes": 0
	}
	
	inbox.generate_mail_tasks(shift.inbox_count)
	
	for i in MODULES:
		for j in i:
			j = null
	
	for i in shift.modules.size():
		var pos := Vector2i(i % 4, int(i / 4))
		print(pos)
		spawn_module(pos, shift.modules[i])
	
	#spawn_module(Vector2i(0, 0), INDESTRUCTIBLE_LIZARD_MODULE)
	#spawn_module(Vector2i(1, 0), LONESOME_GEORGE_MODULE)
	#spawn_module(Vector2i(2, 0), MINOTAUR_MODULE)
	#spawn_module(Vector2i(3, 0), PEANUT_MODULE)

func cleanup_shift() -> void:
	inbox.process_mode = Node.PROCESS_MODE_DISABLED
	
	for module in module_wrapper.get_children():
		module.queue_free()
	
	
	shift_active = false

func spawn_module(location: Vector2i, module: PackedScene) -> void:
	if location.y >= MODULES.size() or location.x >= MODULES[location.y].size():
		printerr("Bad location " + str(location.x) + ", " + str(location.y))
		return
	
	var new_module = module.instantiate()
	module_wrapper.add_child(new_module)
	new_module.position = Vector3(BASE_MODULE_POSITION.x + DELTA_MODULE_POSITION.x * location.x, BASE_MODULE_POSITION.y + DELTA_MODULE_POSITION.y * location.y, -0.5)
	new_module.connect("terminated", module_terminated)
	new_module.connect("escaped", module_escaped)
	MODULES[location.x][location.y] = new_module

func module_terminated() -> void:
	shift_failures.terminations += 1
	#module_failed("Terminated")
func module_escaped() -> void:
	shift_failures.escapes += 1
	#module_failed("Escaped")

#func module_failed(failure_reason: String) -> void:
	#print("Module Failed! " + failure_reason)
