extends TextureRect

export var prize_name: String

func _process(delta):
	if Global.check_prize(prize_name):
		self.show()
	else:
		self.hide()
