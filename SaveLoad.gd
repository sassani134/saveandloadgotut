extends Control

func _on_save_pressed() -> void:
	_save()
	$LineEdit.clear()
	$SpinBox.value = 0


func _on_load_pressed() -> void:
	_load()

func _on_delete_pressed() -> void:
	DirAccess.remove_absolute("saveFile")
	print("GAME DELETED")

func _save() -> void:
	var save_file = FileAccess.open("saveFile", FileAccess.WRITE)
	
	# Go through every object in the Sagroup
	var save_nodes =  get_tree().get_nodes_in_group("SaceLoad")
	for node in save_nodes:
		# check if the node has a save function.
		if !node.has_method("saveObject"):
			print("Node '%s' is missing a save function, skipped" % node.name) # diff between %s messages and "" + str(var) + ""
			continue
		
		# call the node's save function.
		var node_data = node.call("saveObject")
		
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(JSON.stringify(node_data))
		
	save_file.close()
	print("GAME SAVED")

func _load() -> void:
	# Check if the SaveFile exists
	if !FileAccess.file_exists("saveFile"):
		print("Error, no Save File to load.")
		return
	
	var save_file = FileAccess.open("saveFile", FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		var json = JSON.new()
		json.parse(save_file.get_line())
		
		# Get the Data
		var node_data = json.get_data()
		if has_node(node_data["filepath"]):
			get_node(node_data["filepath"]).loadObject(node_data)
	
	save_file.close()
	print("GAME LOADED")
