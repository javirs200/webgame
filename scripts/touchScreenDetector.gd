extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if not OS.has_feature("web_android") and not OS.has_feature("web_ios"):
		hide()
	pass # Replace with function body.
