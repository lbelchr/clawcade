extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("start"):
		_start()


func _on_Start_pressed():
	_start()

func _start():
	get_tree().change_scene("res://cage/Cage.tscn")
