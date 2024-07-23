extends Node3D

const horsepower = 10
const maxSteerAngle = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.relative)
		var f1 = Vector3(event.relative.x,-event.relative.y,0)
		$RigidBody3D.apply_force(f1)
		
		
	#---------procesado para ordenador------------
	
	#eje accelerador
	var thAxis = Input.get_axis("brk","th")
	$Coche.get_node("VehicleBody3D").set_engine_force(thAxis*horsepower)	
	#var brk = Input.get_action_strength("brk")
			
	#comporbacion eje de direccion
	var stAxis = Input.get_axis("std","sti")
	$Coche.get_node("VehicleBody3D").set_steering(stAxis*maxSteerAngle)

	#print("eje de direccion ",stAxis ," eje de acelerador ",thAxis," freno ",brk)
