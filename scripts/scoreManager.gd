extends Node

var _score : int

func _init():
	_score = 0
	print("ScoreManager loaded")
	
func getScore() -> int:
	return _score 
	
func increaseScore(value:int):
	_score += value
