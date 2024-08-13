extends Node3D

func _ready():
	
	$VehicleBody3D.contact_monitor = true
	$VehicleBody3D.max_contacts_reported = 2	
	
	$VehicleBody3D.connect("body_entered",self._on_vehicle_body_entered)
	#$VehicleBody3D.connect("body_shape_entered",self._on_vehicle_body_shape_entered)
	
func _on_vehicle_body_entered(body: PhysicsBody3D):
	print("VehicleBody3D collided with: " + body.name)
	body.scale = Vector3(1.5,1.5,1.5)
