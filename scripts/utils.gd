extends Control

var rev = false

func _is_point_inside(point: Vector2,base :Control) -> bool:
	
	var baseScale = base.get_global_transform_with_canvas().get_scale()
	var baseSize = base.size
	var baseGposition = base.global_position
	var x: bool = point.x >= baseGposition.x and point.x <= baseGposition.x + (baseSize.x * baseScale.x)
	var y: bool = point.y >= baseGposition.y and point.y <= baseGposition.y + (baseSize.y * baseScale.y)
	return x and y

func setFordward():
	rev = false

func setBackward():
	rev = true
	
func swapGear():
	rev = !rev
	
func getGear() -> bool:
	return rev
	
