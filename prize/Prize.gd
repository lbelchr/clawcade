extends Area2D

signal showcase(prize)

var velocity := Vector2.ZERO
var tween
var prize_name

func _ready():
	tween = $Tween
	prize_name = Global.place_prize()

func calculate_grab(area):
	var new_position_x = position.x - area.position.x
	var new_position_y = position.y - area.position.y
	get_parent().remove_child(self)
	area.add_child(self)
	position.x = 0
	position.y = 12

func _on_Prize_area_entered(area):
	if area.name == "Goal":
		Global.add(prize_name)
		emit_signal("showcase", prize_name)
		queue_free()

func _drop_prize():
	tween.interpolate_property(self, "position", self.position, self.position + Vector2(0, 200), .75, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
