extends Node

const ALPHABET = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

const NUM_EMPLOYEES = 10
const OFFICES_PER_FLOOR = 5
var EMPLOYEE_LIST = []

func _ready():
	generate_employee_list()
	
	#print(EMPLOYEE_LIST)

func generate_employee_list() -> void:
	var names = GameText.game_text_dump("EmployeeNames")
	for i in range(NUM_EMPLOYEES):
		var employee = {}
		employee.first_name = names[randi_range(0, names.size() - 1)][0]
		employee.last_name = names[randi_range(0, names.size() - 1)][1]
		employee.index = i
		employee.address = {}
		employee.address.floor = get_floor_from_employee_index(i)
		employee.address.office_number = (i % OFFICES_PER_FLOOR) + 1
		EMPLOYEE_LIST.append(employee)

func get_floor_from_employee_index(index: int) -> String:
	var output = ""
	var floor_index = int(index / OFFICES_PER_FLOOR)
	while floor_index >= 0:
		if floor_index < 26:
			output += ALPHABET[floor_index]
			break
		else:
			output += "A"
			floor_index -= 26
	return output
