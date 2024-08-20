extends Node

var _score : int

func _init():
	print("loading singleton")
	_score = 0
	print("singleton loaded")
	
func getScore() -> int:
	return _score 
	
func increaseScore(value:int):
	_score += value
