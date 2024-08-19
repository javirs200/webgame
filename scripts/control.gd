extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.text = "0"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ScoreLabel.text = str(ScoreManager.getScore())
	pass
