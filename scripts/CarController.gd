extends Node

const Autodrive = preload("res://scripts/autoDrive.gd")

const horsepower = 20
const maxSteerAngle = 0.5

var thAxis = 0
var stAxis = 0
var brake = 0
var rev = false

var carBody3d

var cubesDetector = true

var ap

var score = 0

func _ready():
	
	carBody3d = $VehicleBody3D
	
	if carBody3d != null:
		
		ap = Autodrive.new(carBody3d)
		
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
		
	if Input.is_action_just_pressed("ui_right"):
		ap.doMagic()
		
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
func _on_vehicle_body_entered(body: PhysicsBody3D):
	#print("VehicleBody3D collided with: " + body.name)
	
	#check if collision body is a cube and increase score , <- Car Cube Cetector
	if(body.name == "cubo1" && cubesDetector):
		ScoreManager.increaseScore(1)
		moveAndRestart(body.get_parent_node_3d())

func moveAndRestart(cubeNode:Node3D):
	# disable car cube detector 
	cubesDetector = false 
	
	#stores child collider and removes them
	var child = cubeNode.get_child(0)
	cubeNode.remove_child(child)
	
	#enlarge the cube and wait 1 second
	cubeNode.scale = Vector3(2,2,2)
	await get_tree().create_timer(1).timeout
	
	#hides the cube and search for another position and wait 0,5 seconds
	cubeNode.visible = false
	cubeNode.position = generateRandomPosition(10, 10)
	await get_tree().create_timer(0.5).timeout
	
	#restore detector colliders scale and visibility
	cubesDetector = true
	cubeNode.scale = Vector3(1, 1, 1)
	cubeNode.visible = true
	cubeNode.add_child(child)
		
func generateRandomPosition(Areax : int, Areaz : int) -> Vector3:
	var randomX = randi_range(-Areax, Areax)
	var randomZ = randi_range(-Areaz, Areaz)
	return Vector3(randomX, 0.645, randomZ)
