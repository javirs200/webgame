extends TextureRect

var gears1 = load("res://assetts/images/gears1.svg")
var gears2 = load("res://assetts/images/gears2.svg")

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if Utils._is_point_inside(event.position,self):
				if Utils.getGear():
					Utils.setFordward()
				else:
					Utils.setBackward()

func _process(_delta):
	if(Utils.getGear()):
		texture = gears2
	else:
		texture = gears1
	pass
