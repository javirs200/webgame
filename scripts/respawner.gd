extends VehicleBody3D

var spawnOrigin: Vector3
var spawnRotation: Quaternion
var reset_state: bool = false

func _ready():
	spawnOrigin = global_transform.origin
	spawnRotation = global_transform.basis

func _input(event):
	if event.is_action_pressed("ui_accept"):
		# stop the car
		set_engine_force(0)
		set_steering(0)
		set_brake(1)
		linear_velocity = Vector3(0, 0, 0)

		# reset the car
		reset_state = true

func _integrate_forces(state):
	if reset_state:
		var t :Transform3D = state.get_transform()
		t.origin = spawnOrigin
		t.basis = Basis(spawnRotation)
		reset_state = false
		state.set_transform(t)
