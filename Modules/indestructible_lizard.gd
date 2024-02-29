extends Node3D
signal terminated
signal escaped

var subject_active = true		#Set to false if the subject dies or escapes

var IS_IN_ACID = true
var CURRENT_ACID_LEVEL = 0
const HIGH_ACID_WARNING_LEVEL = 5
const HIGH_ACID_FAILURE_LEVEL = 10
const LOW_ACID_WARNING_LEVEL = -5
const LOW_ACID_FAILURE_LEVEL = -10


@onready var status_label = $ModuleLabel
@onready var switch_acid_button = $ModuleButton
@onready var acid_state_label = $ModuleLabel2

func _ready():
	switch_acid_button.connect("pressed", switch_acid_button_pressed)

func _process(delta):
	if subject_active:
		CURRENT_ACID_LEVEL += delta if IS_IN_ACID else -delta
		
		if status_label:
			if CURRENT_ACID_LEVEL >= HIGH_ACID_FAILURE_LEVEL:
				emit_signal("terminated")
				status_label.text = "Subject Terminated"
				acid_state_label.text = "N/A"
				subject_active = false
			elif CURRENT_ACID_LEVEL >= HIGH_ACID_WARNING_LEVEL:
				status_label.text = "Warning: Subject Termination Imminent"
			elif CURRENT_ACID_LEVEL <= LOW_ACID_FAILURE_LEVEL:
				emit_signal("escaped")
				status_label.text = "Subject Escaped"
				acid_state_label.text = "N/A"
				subject_active = false
			elif CURRENT_ACID_LEVEL <= LOW_ACID_WARNING_LEVEL:
				status_label.text = "Warning: Subject Escape Imminent"
			else:
				status_label.text = "Subject Status is Nominal"
		
		if acid_state_label:
			acid_state_label.text = "Subject Acid Status:\n"
			acid_state_label.text += "Submerged" if IS_IN_ACID else "Unsubmerged"

func switch_acid_button_pressed(_btn) -> void:
	IS_IN_ACID = !IS_IN_ACID
