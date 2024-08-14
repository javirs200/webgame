extends Node

var cameras = []
var current_camera_index = 0

func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	cameras.append($Camera3D1)
	cameras.append($Coche/VehicleBody3D/CarCamera3D)
	
	if cameras.size() > 0:
		cameras[current_camera_index].current = true

# called on input change
func _input(event):

	if Input.is_action_just_pressed("toggle_camera"):
		change_camera()
		
#aux functions
func change_camera():
	if cameras.size() > 0 && current_camera_index < cameras.size():
		cameras[current_camera_index].current = false
		current_camera_index = (current_camera_index + 1) % cameras.size()
		cameras[current_camera_index].current = true
