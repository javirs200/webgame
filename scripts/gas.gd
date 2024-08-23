extends TextureRect

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if Utils._is_point_inside(event.position,self):
				Input.action_press("ui_up")
		else:
			Input.action_release("ui_up")
