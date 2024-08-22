extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_save_pressed() -> void:
	pass # Replace with function body.


func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_delete_pressed() -> void:
	pass # Replace with function body.

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
