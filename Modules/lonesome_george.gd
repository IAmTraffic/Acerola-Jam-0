extends Node3D
signal terminated
signal escaped
var subject_active = true		#Set to false if the subject dies or escapes

const MIN_LONELY_TIMER = 5.0
const MAX_LONELY_TIMER = 10.0
const TIME_TO_RESPOND = 5.0

@onready var respond_btn = $ModuleButton
@onready var lonely_indicator_light = $ModuleIndicatorLight
@onready var lonely_timer = $LonelyTimer
@onready var respond_timer = $RespondTimer

var IS_LONELY := false

func _ready():
	lonely_indicator_light.beeps = true
	
	respond_btn.connect("pressed", on_respond_pressed)
	
	respond_timer.wait_time = TIME_TO_RESPOND
	
	set_lonely_timer()

func on_respond_pressed(_btn) -> void:
	if IS_LONELY and subject_active:
		lonely_indicator_light.set_state(false)
		IS_LONELY = false
		respond_timer.stop()
		set_lonely_timer()

func set_lonely_timer() -> void:
	lonely_timer.wait_time = randf_range(MIN_LONELY_TIMER, MAX_LONELY_TIMER)
	lonely_timer.start()


func _on_lonely_timer_timeout():
	respond_timer.start()
	IS_LONELY = true
	lonely_indicator_light.set_state(true)


func _on_respond_timer_timeout():
	emit_signal("escaped")
	subject_active = false
