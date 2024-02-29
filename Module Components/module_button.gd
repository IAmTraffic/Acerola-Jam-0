extends StaticBody3D
signal pressed(button)

func press() -> void:
	pressed.emit(self)
