extends Node3D
signal terminated
signal escaped

var subject_active = true		#Set to false if the subject dies or escapes


const PEANUT_ROOM = preload("res://Modules/peanut_room.tscn")

const TIME_LEFT_WARNING_THRESHOLD = 4.0
const TIMER_DURATION = 14.0

@onready var room_wrapper = $SubViewport/RoomWrapper
@onready var monitor = $Monitor
@onready var timer_wrapper = $TimerWrapper

@onready var module_label = $ModuleLabel
@onready var camera_next = $CameraNext
@onready var camera_prev = $CameraPrev
@onready var module_indicator_light = $ModuleIndicatorLight


var current_monitored_room_index: int

func _ready():
	setup_rooms(2)
	set_monitor_camera(0)

func _process(_delta):
	module_indicator_light.set_state(false)
	#print("")
	for i in timer_wrapper.get_children().size():
		var timer: Timer = timer_wrapper.get_children()[i]
		#print(timer.time_left)
		if timer.time_left < TIME_LEFT_WARNING_THRESHOLD and i != current_monitored_room_index:
			module_indicator_light.set_state(true)

func on_timer_timeout() -> void:
	emit_signal("escaped")

func set_monitor_camera(camera_index: int) -> void:
	if camera_index >= room_wrapper.get_children().size() or camera_index < 0:
		return
	
	current_monitored_room_index = camera_index
	
	#Show the correct room
	for i in range(room_wrapper.get_children().size()):
		var room = room_wrapper.get_children()[i]
		room.hide()
		room.get_node("Camera3D").current = false
		
		timer_wrapper.get_children()[i].start()
	
	room_wrapper.get_children()[camera_index].show()
	room_wrapper.get_children()[camera_index].get_node("Camera3D").current = true
	room_wrapper.get_children()[camera_index].random_move_peanut()
	
	#Reset this peanut's timer
	timer_wrapper.get_children()[camera_index].stop()
	
	#Update the display
	module_label.text = str(camera_index)



func setup_rooms(room_count: int) -> void:
	for room_i in room_count:
		var room = PEANUT_ROOM.instantiate()
		room_wrapper.add_child(room)
		room.hide()
		
		var timer := Timer.new()
		timer.name = "Timer" + str(room_i)
		timer.wait_time = TIMER_DURATION
		timer_wrapper.add_child(timer)
		timer.connect("timeout", on_timer_timeout)
		timer.start()


func _on_camera_next_pressed(_button):
	set_monitor_camera((current_monitored_room_index + 1) % room_wrapper.get_children().size())


func _on_camera_prev_pressed(_button):
	set_monitor_camera(current_monitored_room_index - 1 if current_monitored_room_index > 0 else room_wrapper.get_children().size() - 1)
