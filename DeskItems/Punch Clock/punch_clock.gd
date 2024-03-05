extends StaticBody3D
signal pressed(button)

func press(button_pressed, button_index):
	if button_index != 1:
		return
	
	if button_pressed:
		pressed.emit(self)
