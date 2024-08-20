extends Control

var uiRev = false

var img

# Called when the node enters the scene tree for the first time.
func _ready():
	img = $TextureRect
	$ScoreLabel.text = "0"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ScoreLabel.text = str(ScoreManager.getScore())
	
	if(uiRev):
		img.texture = load("res://assetts/images/rear.svg")		
	else:
		img.texture = load("res://assetts/images/fwd.svg")
	
	pass
	
func _input(event):
	
	if Input.is_action_pressed("rev"):
		uiRev = !uiRev
	
