extends Node3D

const horsepower = 20
const maxSteerAngle = 0.5

var cameras = []
var current_camera_index = 0

var thAxis = 0
var stAxis = 0
var brake = 0
var rev = false

var carBody3d = null

# Called when the node enters the scene tree for the first time.
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	cameras.append($Camera3D1)
	cameras.append($Coche/VehicleBody3D/CarCamera3D)
	
	if cameras.size() > 0:
		cameras[current_camera_index].current = true

	carBody3d = $Coche.get_node("VehicleBody3D")
	
	$CanvasLayer/Label.text = "loading..."
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):

	if carBody3d != null:

		var gas = 0
		if rev && thAxis > 0:
			gas = -thAxis
		else :
			gas = thAxis
			
		carBody3d.set_engine_force(gas * horsepower)
		carBody3d.set_steering(stAxis * maxSteerAngle)
		carBody3d.set_brake(brake)
		
		$CanvasLayer/Label.text = "R " + str(rev) + " brake " + str(brake) + " th " + str(gas) + " st " + str(stAxis)
	pass

# called on input change
func _input(event):

	# actualizamos los valores de los ejes
	stAxis = Input.get_axis("std", "sti")
	
	#---------actions proces-----------
	if Input.is_action_just_pressed("brk"):
		brake = 1
	elif Input.is_action_just_released("brk"):
		brake = 0

	if Input.is_action_just_pressed("toggle_camera"):
		change_camera()
		
	thAxis = Input.get_action_strength("th")

	if Input.is_action_pressed("rev"):
		rev = !rev
	
#aux functions
func change_camera():
	if cameras.size() > 0 && current_camera_index < cameras.size():
		cameras[current_camera_index].current = false
		current_camera_index = (current_camera_index + 1) % cameras.size()
		cameras[current_camera_index].current = true
