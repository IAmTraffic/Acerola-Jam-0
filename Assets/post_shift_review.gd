extends Control

@onready var label = %Label

var shift_failures = {}

func render_review() -> void:
	label.text = str(shift_failures)


func _on_close_btn_pressed():
	hide()
