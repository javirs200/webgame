extends Node

var cameras = []
var current_camera_index = 0
const orbit_camera_distance = 5.0
var movement = Vector3(0,0,0)

func _ready():

	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	cameras.append($Camera3D1)
	cameras.append($Coche/VehicleBody3D/CarCamera3D)
	cameras.append($Coche/VehicleBody3D/RearCarCamera3D)
	cameras.append($Coche/VehicleBody3D/OrbitCamera3D)
	
	if cameras.size() > 0:
		cameras[current_camera_index].current = true

# called on input change
func _input(_event):

	if Input.is_action_just_pressed("toggle_camera"):
		change_camera()
		
		
	if Input.is_action_pressed("view_L"):
		movement = Vector3(0.5,0,0)
	elif Input.is_action_pressed("view_R"):
		movement = Vector3(-0.5,0,0)
	elif Input.is_action_pressed("view_up"):
		movement = Vector3(0,0,0.5)
	elif Input.is_action_pressed("view_dn"):
		movement = Vector3(0,0,-0.5)
	else:
		movement = Vector3(0,0,0
		)
		
		
#aux functions
func change_camera():
	if cameras.size() > 0 && current_camera_index < cameras.size():
		cameras[current_camera_index].current = false
		current_camera_index = (current_camera_index + 1) % cameras.size()
		cameras[current_camera_index].current = true
		
func _physics_process(_delta):
	cameras[current_camera_index].position += movement
