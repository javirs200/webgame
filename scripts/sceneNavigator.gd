extends Control

var navigate = false

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if _is_point_inside(event.position):
				navigate = true
				
	elif (event is InputEventKey) or (event is InputEventJoypadButton):
		if event.pressed:
			navigate = true
			
	if navigate:
		$Panel/Label.text = "Loading..."
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _is_point_inside(point: Vector2) -> bool:
	var x: bool = point.x >= global_position.x and point.x <= global_position.x + (size.x * get_global_transform_with_canvas().get_scale().x)
	var y: bool = point.y >= global_position.y and point.y <= global_position.y + (size.y * get_global_transform_with_canvas().get_scale().y)
	return x and y				
