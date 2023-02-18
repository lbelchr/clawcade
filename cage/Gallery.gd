extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if self.visible:
		print("checking")
		if Input.is_action_just_pressed("reset"):
			get_tree().paused = false
			Global.reset()
			get_tree().change_scene("res://menu/StartMenu.tscn")
		if Input.is_action_just_pressed("start"):
			get_tree().paused = false
			self.hide()


func _on_Gallery_popup_hide():
	get_tree().paused = false
	self.hide()
