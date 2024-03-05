extends StaticBody3D
signal inbox_cleared(num_mistakes)

const MAIL_SCENE = preload("res://DeskItems/Inbox/mail.tscn")
const MAIL_MESH_FOR_INBOX_SCENE = preload("res://DeskItems/Inbox/mail_mesh_for_inbox.tscn")

var mail_tasks := []
var current_mail_task := {}

var num_mistakes := 0

@onready var mail_mesh_wrapper = $MailMeshWrapper


func _process(_delta):
	#Update mesh
	for i in range(mail_mesh_wrapper.get_children().size()):
		if i >= mail_tasks.size():
			mail_mesh_wrapper.get_children()[i].queue_free()
	for i in range(mail_tasks.size() - mail_mesh_wrapper.get_children().size()):
		var mail_mesh = MAIL_MESH_FOR_INBOX_SCENE.instantiate()
		mail_mesh_wrapper.add_child(mail_mesh)
		mail_mesh.position.y += mail_mesh_wrapper.get_children().size() / 9.0
	
	#Handle finishing your inbox
	if mail_tasks.size() == 0 and current_mail_task == {}:
		inbox_cleared.emit(num_mistakes)

func generate_mail_tasks(num_tasks: int) -> void:
	num_mistakes = 0
	var temp_employee_list = Employees.EMPLOYEE_LIST.duplicate(true)
	for i in num_tasks:
		if temp_employee_list.size() < 1:
			break
		
		var employee = temp_employee_list.pop_at(randi_range(0, temp_employee_list.size() - 1))
		var task = {}
		task.recipient = employee.last_name + ", " + employee.first_name
		task.destination = employee.address
		mail_tasks.append(task)


func press(button_pressed, button_index):
	if button_index != 1:
		return
	
	if button_pressed:
		if mail_tasks.size() > 0 and current_mail_task == {}:
			var mail = MAIL_SCENE.instantiate()
			add_child(mail)
			mail.connect("returned", on_current_mail_returned)
			mail.connect("submitted", on_current_mail_submitted)
			
			current_mail_task = mail_tasks.pop_back()
			mail.set_recipient(current_mail_task.recipient)

func on_current_mail_returned() -> void:
	mail_tasks.append(current_mail_task)
	current_mail_task = {}

func on_current_mail_submitted(player_destination: String) -> void:
	var player_guess = parse_player_guess(player_destination)
	if player_guess.floor != current_mail_task.destination.floor or player_guess.office_number != current_mail_task.destination.office_number:
		num_mistakes += 1
	current_mail_task = {}

func parse_player_guess(guess: String) -> Dictionary:
	var floor = ""
	var office_num = ""
	for char in guess:
		if char.is_valid_int():
			office_num += char
		else:
			floor += char
	return {
		"floor": floor.to_upper(),
		"office_number": int(office_num)
	}
