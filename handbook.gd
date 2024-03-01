extends StaticBody3D

const REST_POSITION = Vector3(0.703, 0.918, -0.266)
const REST_ROTATION = Vector3(-71, 1.7, -33.4)
const READ_POSITION = Vector3(0, 1.321, 1.719)
const READ_ROTATION = Vector3.ZERO

const LERP_RATE = 0.1

var is_being_read := false

var target_position = REST_POSITION
var target_rotation = REST_ROTATION

#func _ready():
	#transform.origin = REST_POSITION
	#rotation_degrees = REST_ROTATION

func _process(_delta):
	#print(transform.origin)
	transform.origin = lerp(transform.origin, target_position, LERP_RATE)
	rotation_degrees.x = lerp_angle(rotation_degrees.x, target_rotation.x, LERP_RATE)
	rotation_degrees.y = lerp_angle(rotation_degrees.y, target_rotation.y, LERP_RATE)
	rotation_degrees.z = lerp_angle(rotation_degrees.z, target_rotation.z, LERP_RATE)

func press(button_pressed, button_index):
	if button_index != 1:
		return
	
	if button_pressed:
		is_being_read = !is_being_read
		target_position = READ_POSITION if is_being_read else REST_POSITION
		target_rotation = READ_POSITION if is_being_read else REST_POSITION
		#target_rotation = READ_ROTATION if is_being read else REST_ROTATION
		#if transform.origin == REST_POSITION:
			#target_position = READ_POSITION
			#target_rotation = READ_ROTATION
			##transform.origin = READ_POSITION
			##rotation_degrees = READ_ROTATION
		#else:
			#target_position = REST_POSITION
			#target_rotation = REST_ROTATION
			#transform.origin = REST_POSITION
			#rotation_degrees = REST_ROTATION
