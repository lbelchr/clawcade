extends Node

func _ready():

	var prize_one = load("res://prize/Prize.tscn")
	var prize_two = load("res://prize/Prize.tscn")
	var prize_three = load("res://prize/Prize.tscn")
	
	var prize_node_one = prize_one.instance()
	var prize_node_two = prize_one.instance()
	var prize_node_three = prize_one.instance()

	
	add_child(prize_node_one)
	prize_node_one.connect("showcase", $CanvasLayer/Showcase, "_show")
	add_child(prize_node_two)
	prize_node_two.connect("showcase", $CanvasLayer/Showcase, "_show")
	add_child(prize_node_three)
	prize_node_three.connect("showcase", $CanvasLayer/Showcase, "_show")
	
	prize_node_one.position = Vector2(145, 166)
	prize_node_two.position = Vector2(182, 166)
	prize_node_three.position = Vector2(219, 166)
	
	$Claw.connect("lose_token", $Buttons/Token1, "_deplete")
	$Claw.connect("lose_token", $Buttons/Token2, "_deplete")
	$Claw.connect("lose_token", $Buttons/Token3, "_deplete")
	
	$Claw.connect("left_arrow", $Buttons/LeftArrow, "play")
	$Claw.connect("stop_controls", $Buttons/LeftArrow, "play")
	
	$Claw.connect("right_arrow", $Buttons/RightArrow, "play")
	$Claw.connect("stop_controls", $Buttons/RightArrow, "play")
	
	$Claw.connect("down_arrow", $Buttons/DownArrow, "play")
	$Claw.connect("stop_controls", $Buttons/DownArrow, "play")

	$Claw.connect("grab_button", $Buttons/GrabButton, "play")
	$Claw.connect("stop_controls", $Buttons/GrabButton, "play")


func _on_Showcase_popup_hide():
	if Global.is_win_condition():
		$CanvasLayer/Win.popup()
	else:
		var children = get_children()
		for child in children:
			if "Prize" in child.name:
				return
		get_tree().reload_current_scene()


func _on_Win_popup_hide():
	Global.reset()
	get_tree().change_scene("res://menu/StartMenu.tscn")


func _on_GameOver_popup_hide():
	Global.reset()
	get_tree().change_scene("res://menu/StartMenu.tscn")
