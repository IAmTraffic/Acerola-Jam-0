extends StaticBody3D
signal pressed(button)
signal unpressed(button)

const BASE_DEPTH := 0.025
const PRESSED_DEPTH = 0.01

var toggle_mode = false
var is_toggled = false

@onready var pressed_duration_timer = $PressedDurationTimer
@onready var mesh_instance_3d = $MeshInstance3D


const MODULE_BUTTON_BASE_MATERIAL = preload("res://Module Components/module_button_base_material.tres")
const MODULE_BUTTON_TOGGLED_MATERIAL = preload("res://Module Components/module_button_toggled_material.tres")

func _ready():
	mesh_instance_3d.set_surface_override_material(0, MODULE_BUTTON_BASE_MATERIAL)

func press(button_pressed, button_index) -> void:
	if !button_pressed or button_index != 1:
		return
	
	if toggle_mode:
		is_toggled = !is_toggled
		if is_toggled:
			pressed.emit(self)
			position.z = PRESSED_DEPTH
			#Play Sound - TODO
			mesh_instance_3d.set_surface_override_material(0, MODULE_BUTTON_TOGGLED_MATERIAL)
		else:
			unpressed.emit(self)
			position.z = BASE_DEPTH
			#Play Sound - TODO
			mesh_instance_3d.set_surface_override_material(0, MODULE_BUTTON_BASE_MATERIAL)
	else:
		if pressed_duration_timer.is_stopped():
			pressed.emit(self)
			pressed_duration_timer.start()
			position.z = PRESSED_DEPTH
			#Play Sound - TODO


func _on_pressed_duration_timer_timeout():
	position.z = BASE_DEPTH
	unpressed.emit(self)
	#Play Sound - TODO
