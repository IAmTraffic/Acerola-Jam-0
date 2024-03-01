extends Node

#const GAME_TEXT = preload("res://Assets/GameText.csv")
var LOADED_SHEETS  = {}

func game_text_dump(sheet_name: String) -> Array:
	return get_sheet(sheet_name)

func get_text(sheet_name: String, cell_coord: Vector2i) -> String:
	if get_sheet(sheet_name).size() == 0:
		return ""
	if cell_coord.x < 0 or cell_coord.y < 0:
		return ""
	if cell_coord.y >= get_sheet(sheet_name).size():
		return ""
	if cell_coord.x >= get_sheet(sheet_name)[cell_coord.y].size():
		return ""
	
	return get_sheet(sheet_name)[cell_coord.y][cell_coord.x]

func get_col(sheet_name: String, col_index: int) -> Array:
	if get_sheet(sheet_name).size() == 0:
		return []
	if col_index < 0:
		return []
	
	var output = []
	for col in get_sheet(sheet_name):
		if col_index >= col.size():
			return []
		else:
			output.append(col[col_index])
	return output

func get_row(sheet_name: String, row_index: int) -> Array:
	if get_sheet(sheet_name).size() == 0:
		return []
	if row_index < 0:
		return []
	if row_index >= get_sheet(sheet_name).size():
		return []
	
	return get_sheet(sheet_name)[row_index]

func get_sheet(sheet_name: String) -> Array:
	#If we have it cached, return it
	if sheet_name in LOADED_SHEETS.keys():
		return LOADED_SHEETS[sheet_name]
	
	#Otherwise, load it into the cache and return it
	var sheet_path = "res://Assets/Text/" + str(sheet_name) + ".csv"
	if FileAccess.file_exists(sheet_path):
		var sheet = load(sheet_path)
		LOADED_SHEETS[sheet_name] = sheet.records
		return sheet.records
	else:
		printerr("No such file: " + str(sheet_path))
		return []

func forget_sheet(sheet_name: String) -> void:
	if sheet_name in LOADED_SHEETS.keys():
		LOADED_SHEETS.erase(sheet_name)
