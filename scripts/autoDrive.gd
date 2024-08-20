class_name  AutoDrive

var _mycar : VehicleBody3D

func _init(car : VehicleBody3D):
	# code goes here
	if car:
		_mycar = car
	pass

#this method do nothing cause steering is overwrited by other script every pyhsics process , but this operates good but for very sort time
func doMagic():
	_steer(0)
	_mycar.get_tree().create_timer(2).timeout.connect(_steer.bind(0.5))
	
func _steer(degrees : float):
	print("tring to steer")
	_mycar.steering = degrees
	print("done")
	
