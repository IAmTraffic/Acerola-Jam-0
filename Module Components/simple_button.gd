extends StaticBody3D
signal pressed(button)

func press(button_pressed, button_index):
	if button_pressed and button_index == 1:
		pressed.emit(self)
