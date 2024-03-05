extends StaticBody3D
signal returned
signal submitted(guess)

var REST_POSITION = Vector3.ZERO
var REST_ROTATION = Vector3.ZERO
var READ_POSITION = Vector3(0, 1.321, 1.719)
var READ_ROTATION = Vector3(0, 0, 0)
const LERP_RATE = 0.13
var target_position = READ_POSITION
var target_rotation = READ_ROTATION

var OUTBOX_POSITION = Vector3(0, 0, 0)

const RETURNED_HOME_THRESHOLD = 0.1

@onready var recipient_label = %RecipientLabel
@onready var destination_label = %DestinationLabel


func _ready():
	REST_POSITION = get_parent().global_transform.origin
	REST_ROTATION = get_parent().global_rotation_degrees
	
	global_transform.origin = REST_POSITION
	global_rotation_degrees = REST_ROTATION

func _process(_delta):
	#Moving to and from rest and read positions / rotations
	global_transform.origin = lerp(global_transform.origin, target_position, LERP_RATE)
	global_rotation_degrees.x = lerp_angle(global_rotation_degrees.x, deg_to_rad(target_rotation.x), LERP_RATE)
	global_rotation_degrees.y = lerp_angle(global_rotation_degrees.y, deg_to_rad(target_rotation.y), LERP_RATE)
	global_rotation_degrees.z = lerp_angle(global_rotation_degrees.z, deg_to_rad(target_rotation.z), LERP_RATE)
	
	#Delete this ghost if it is put back in the inbox
	if REST_POSITION.distance_to(global_transform.origin) < RETURNED_HOME_THRESHOLD:
		returned.emit()
		
		queue_free()
	
	#Delete this ghost if it has been submitted
	if OUTBOX_POSITION.distance_to(global_transform.origin) < RETURNED_HOME_THRESHOLD:
		submitted.emit(destination_label.text)
		
		queue_free()
	
	
	#Handle backspace on the destination label
	if Input.is_action_just_pressed("ui_text_backspace"):
		if destination_label.text.length() > 0:
			destination_label.text = destination_label.text.substr(0, destination_label.text.length() - 1)
	
	#Handle queueing a submission of the destination label
	if Input.is_action_just_pressed("ui_accept"):
		if destination_label.text.length() > 0:
			target_position = OUTBOX_POSITION

func set_recipient(recipient: String) -> void:
	recipient_label.text = recipient

func _input(event):
	#Handle writing in the destination field
	if event is InputEventKey and event.pressed:
		destination_label.text += PackedByteArray([event.unicode]).get_string_from_utf8()

func press(button_pressed, button_index):
	if button_index != 1:
		return
	
	if button_pressed:
		target_position = REST_POSITION
		target_rotation = REST_ROTATION
