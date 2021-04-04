extends Spatial


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		get_tree().quit()
	if Input.is_action_just_pressed("ENTER"):
		get_tree().reload_current_scene()
