extends MeshInstance3D

const MODULE_INDICATOR_LIGHT_OFF_MATERIAL = preload("res://Module Components/module_indicator_light_off_material.tres")
const MODULE_INDICATOR_LIGHT_ON_MATERIAL = preload("res://Module Components/module_indicator_light_on_material.tres")

var STATE := false

func _ready():
	set_state(false)

func set_state(is_on: bool) -> void:
	set_surface_override_material(0, MODULE_INDICATOR_LIGHT_ON_MATERIAL if is_on else MODULE_INDICATOR_LIGHT_OFF_MATERIAL)
	STATE = is_on

func get_state() -> bool:
	return STATE