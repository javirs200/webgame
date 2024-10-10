extends Node

const horsepower:float = 50
const maxSteerAngle:float = 0.6

var thAxis:float = 0
var stAxis:float = 0
var brake:float = 0

var carBody3d: VehicleBody3D

var cubesDetector:bool = true

var score:int = 0

func _ready():
		
	carBody3d = $VehicleBody3D
	
	if carBody3d != null:
		
		carBody3d.contact_monitor = true
		carBody3d.max_contacts_reported = 2

		carBody3d.connect("body_entered", self._on_vehicle_body_entered)

func _physics_process(delta):
	if carBody3d != null:
		var gas = 0
		if Utils.getGear() && thAxis > 0:
			gas = -thAxis
		else:
			gas = thAxis
			
		carBody3d.set_engine_force(gas * horsepower)
		carBody3d.set_steering(stAxis * maxSteerAngle)
		carBody3d.set_brake(brake)
pass

# called on input change on phisical device not touch screen
func _input(event):
	
	# actualizamos los valores de los ejes
	stAxis = Input.get_axis("ui_right", "ui_left") # left stick left and right on gamepad or left and right arrows on keyboard

	#---------actions proces-----------
	if Input.is_action_just_pressed("ui_down"): # Down on keyboard or left stick down on gamepad
		brake = 1
	elif Input.is_action_just_released("ui_down"):
		brake = 0
		
	thAxis = Input.get_action_strength("ui_up") # Up on keyboard or left stick up on gamepad

	if Input.is_action_pressed("rev"): # R on keyboard
		print("reverse keyboard")
		Utils.swapGear()
	elif Input.is_action_pressed("ui_select"): # Y on Xbox controller or Triangle on PS4 controller or space on keyboard
		print("reverse gamepad")
		Utils.swapGear()

	if Input.is_action_pressed("ui_cancel"): # B on Xbox controller or Circle on PS4 controller or ESC on keyboard
		get_tree().quit()
	
func _on_vehicle_body_entered(body: PhysicsBody3D):
	#print("VehicleBody3D collided with: " + body.name)
	
	#check if collision body is a cube and increase score , <- Car Cube Cetector
	if (body.name == "cubo1" && cubesDetector):
		ScoreManager.increaseScore(1)
		moveAndRestart(body.get_parent_node_3d())

func moveAndRestart(cubeNode: Node3D):
	# disable car cube detector 
	cubesDetector = false
	
	#stores child collider and removes them
	var child = cubeNode.get_child(0)
	child.position = Vector3(0, -2, 0)
	
	#enlarge the cube and wait 1 second
	cubeNode.scale = Vector3(2, 2, 2)
	await get_tree().create_timer(1).timeout
	
	#hides the cube and search for another position and wait 0,5 seconds
	cubeNode.visible = false
	cubeNode.position = generateRandomPosition(10, 10)
	await get_tree().create_timer(0.5).timeout
	
	#restore detector colliders scale and visibility
	cubesDetector = true
	cubeNode.scale = Vector3(1, 1, 1)
	cubeNode.visible = true
	child.position = Vector3(0, 0, 0)
	
		
func generateRandomPosition(Areax: int, Areaz: int) -> Vector3:
	var randomX = randi_range(-Areax, Areax)
	var randomZ = randi_range(-Areaz, Areaz)
	return Vector3(randomX, 0.645, randomZ)
