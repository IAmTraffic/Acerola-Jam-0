extends StaticBody3D

const REST_POSITION = Vector3(-0.279, 0.951, -0.295)
const REST_ROTATION = Vector3(70.7, -180, -26)
const READ_POSITION = Vector3(0, 1.321, 1.719)
const READ_ROTATION = Vector3(0, -180, 0)
const LERP_RATE = 0.13
var is_being_read := false
var target_position = REST_POSITION
var target_rotation = REST_ROTATION

@onready var page = $Page
@onready var company_directory_control = $Page/SubViewport/CompanyDirectoryControl

func _input(event):
	if is_being_read:
		company_directory_control._input(event)

func _process(_delta):
	#Moving to and from rest and read positions / rotations
	transform.origin = lerp(transform.origin, target_position, LERP_RATE)
	rotation.x = lerp_angle(rotation.x, deg_to_rad(target_rotation.x), LERP_RATE)
	rotation.y = lerp_angle(rotation.y, deg_to_rad(target_rotation.y), LERP_RATE)
	rotation.z = lerp_angle(rotation.z, deg_to_rad(target_rotation.z), LERP_RATE)

func press(button_pressed, button_index):
	if button_index != 1:
		return
	
	if button_pressed:
		is_being_read = !is_being_read
		target_position = READ_POSITION if is_being_read else REST_POSITION
		target_rotation = READ_ROTATION if is_being_read else REST_ROTATION
