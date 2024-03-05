extends Control

const NUM_NAMES_PER_PAGE = 40
const SCROLL_STEP = 30

const PAGE_TAGS = "[color=#000000]"
const PAGE_TAGS_END = "[/color]"

@onready var page_contents = $PageContents

func _ready():
	set_page(0)

func _input(event):
	#Handle scrolling
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 5:
			page_contents.get_v_scroll_bar().value += SCROLL_STEP
		if event.button_index == 4:
			page_contents.get_v_scroll_bar().value -= SCROLL_STEP

func set_page(index: int) -> void:
	page_contents.text = PAGE_TAGS + generate_page(index) + PAGE_TAGS_END

func generate_page(index: int) -> String:
	var output = ""
	for i in range(NUM_NAMES_PER_PAGE):
		if index + i < Employees.EMPLOYEE_LIST.size():
			var employee = Employees.EMPLOYEE_LIST[index + i]
			output += employee.last_name + ", " + employee.first_name + " - " + employee.address.floor + str(employee.address.office_number) + "\n"
	return output
