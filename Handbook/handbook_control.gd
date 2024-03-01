extends Control

@onready var scroll_container = $ScrollContainer

#func _process(delta):
	#scroll_container.scroll_vertical -= 100 * delta

func _input(event):
	if event is InputEventMouseButton and event.button_index == 5 and event.pressed:
		print("aldfj")
		scroll_container.set_deferred("scroll_vertical", 600)
		#scroll_container.set_deferred("scroll_vertical", 100)
