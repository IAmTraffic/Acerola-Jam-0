extends StaticBody3D

const REST_POSITION = Vector3(0.703, 0.92, -0.266)
const REST_ROTATION = Vector3(-71, 1.7, -33.4)
const READ_POSITION = Vector3(0, 1.321, 1.719)
const READ_ROTATION = Vector3.ZERO
const LERP_RATE = 0.13
var is_being_read := false
var target_position = REST_POSITION
var target_rotation = REST_ROTATION


@onready var prev_page_btn = $"Prev Page"
@onready var next_page_btn = $"Next Page"
@onready var page_contents = %PageContents
@onready var header = %Header
@onready var handbook_page = %HandbookPage
@onready var handbook_control = $HandbookPage/SubViewport/HandbookControl



var current_page := 0


func _ready():
	next_page_btn.connect("pressed", on_btn_pressed)
	prev_page_btn.connect("pressed", on_btn_pressed)
	
	set_page(0)

func on_btn_pressed(button) -> void:
	if button == next_page_btn:
		set_page(current_page + 1 if current_page < GameText.get_row("Handbook", 1).size() - 1 else 0)
	elif button == prev_page_btn:
		set_page(current_page - 1 if current_page > 0 else GameText.get_row("Handbook", 1).size() - 1)

func set_page(new_page):
	current_page = new_page
	
	#Animations or sound effects go here
	
	page_contents.text = GameText.get_text("Handbook", Vector2i(current_page, 1))
	#header.text = GameText.get_text("Handbook", Vector2i(current_page, 0))
	
	header.font_size = 256

func _process(_delta):
	#Moving to and from rest and read positions / rotations
	transform.origin = lerp(transform.origin, target_position, LERP_RATE)
	rotation.x = lerp_angle(rotation.x, deg_to_rad(target_rotation.x), LERP_RATE)
	rotation.y = lerp_angle(rotation.y, deg_to_rad(target_rotation.y), LERP_RATE)
	rotation.z = lerp_angle(rotation.z, deg_to_rad(target_rotation.z), LERP_RATE)
	
	#Resize Header
	if header.get_aabb().size.x > 0.2373:
		header.font_size -= 5
	#print(header.get_aabb())
	#header.custom_aabb = AABB(Vector3(0, 0, 0), Vector3(0, 0, 0))
	#header.font_size = 64
	#print(header.get_aabb())
	#while(header.get_aabb().size.x > 0.2373):
		#print(header.get_aabb().size)
		#header.font_size -= 1

func _input(event):
	if is_being_read:
		handbook_control._input(event)

func press(button_pressed, button_index):
	if button_index != 1:
		return
	
	if button_pressed:
		is_being_read = !is_being_read
		target_position = READ_POSITION if is_being_read else REST_POSITION
		target_rotation = READ_ROTATION if is_being_read else REST_ROTATION
