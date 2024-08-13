extends Node3D

const horsepower = 20
const maxSteerAngle = 0.5

var thAxis = 0
var stAxis = 0
var brake = 0
var rev = false

var carBody3d

func _ready():
	carBody3d = $VehicleBody3D
	
	if carBody3d != null:
		carBody3d.contact_monitor = true
		carBody3d.max_contacts_reported = 2	

		carBody3d.connect("body_entered",self._on_vehicle_body_entered)

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
		
	thAxis = Input.get_action_strength("th")

	if Input.is_action_pressed("rev"):
		rev = !rev
		
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
func _on_vehicle_body_entered(body: PhysicsBody3D):
	print("VehicleBody3D collided with: " + body.name)
	if(body.name == "cubo1"):
		body.get_parent_node_3d().scale = Vector3(2,2,2)
		body.queue_free()
