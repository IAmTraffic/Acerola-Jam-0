extends Control

const SCROLL_STEP = 30

const PAGE_TAGS = "[color=#000000]"
const PAGE_TAGS_END = "[/color]"
const HEADER_TAGS = "[font_size=32][center][color=#000000]"
const HEADER_TAGS_END = "[/color][/center][/font_size]"

@onready var page_contents = %PageContents
@onready var header_contents = %HeaderContents


func _input(event):
	#Handle scrolling
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 5:
			page_contents.get_v_scroll_bar().value += SCROLL_STEP
		if event.button_index == 4:
			page_contents.get_v_scroll_bar().value -= SCROLL_STEP

func set_page_contents(contents: String) -> void:
	page_contents.text = PAGE_TAGS + contents + PAGE_TAGS_END

func set_header_contents(contents: String) -> void:
	header_contents.text = HEADER_TAGS + contents + HEADER_TAGS_END
