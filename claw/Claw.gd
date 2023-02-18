extends Area2D

signal drop
signal lose_token(value)
signal left_arrow(anim, backwards)
signal right_arrow(anim, backwards)
signal down_arrow(anim, backwards)
signal grab_button(anim, backwards)
signal stop_controls(anim, backwards)

export var speed = 45

enum States {STOPPED, MOVING_RIGHT, MOVING_LEFT, MOVING_DOWN, MOVING_UP, HOLD}
var _state: int = States.STOPPED
var _grabbed: bool = false
var _lose_token: bool = false
var tokens

export(NodePath) var game_over_screen
export(NodePath) var gallery_screen
var game_over_node
var gallery_node



func _ready():
	game_over_node = get_node(game_over_screen)
	gallery_node = get_node (gallery_screen)
	tokens = Global.check_tokens()


func _physics_process(delta):

	var velocity = Vector2()
	if Input.is_action_just_pressed("start"):
		gallery_node.call_deferred("popup")
		get_tree().paused = true
	if Input.is_action_just_pressed("right") && _state == States.STOPPED:		
		_change_state(States.MOVING_RIGHT)
		emit_signal("right_arrow", "default", false)
		
	if Input.is_action_just_pressed("down") && !_grabbed && (_state == States.MOVING_RIGHT || _state == States.MOVING_LEFT):
		_change_state(States.HOLD)
		emit_signal("right_arrow", "default", true)
		emit_signal("down_arrow", "default", false)
		$Grab.play("Grab")
		yield($Grab, "animation_finished")
		$Grab.stop()
		_change_state(States.MOVING_DOWN)
		_lose_token = true
		
	if Input.is_action_just_pressed("stop") && !_grabbed && (_state == States.MOVING_DOWN || _state == States.MOVING_UP):
		_change_state(States.HOLD)
		emit_signal("down_arrow", "default", true)
		emit_signal("grab_button", "default", false)
		_grabbed = true
		$Grab.play("Grab", true)
		yield($Grab, "animation_finished")
		$Grab.stop()
		var areas = get_overlapping_areas()
		if areas.size() > 0:
			for area in areas:
				if "Prize" in area.name:
					area.calculate_grab(self)
					self.connect("drop", area, "_drop_prize")
					_lose_token = false
		_change_state(States.MOVING_UP)
		
	
	match _state:
		States.MOVING_RIGHT:
			velocity.x += 1			
		States.MOVING_LEFT:
			velocity.x += -1
		States.MOVING_DOWN:
			velocity.y += 1
		States.MOVING_UP:
			velocity.y += -1
		States.STOPPED:
			velocity.y = 0
			velocity.x = 0
		States.HOLD:
			velocity.y = 0
			velocity.x = 0
		
	if velocity.x != 0 || velocity.y != 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta

func _on_Rail_area_entered(area):
	if _state == States.MOVING_UP:
		position.y = 104
		_change_state(States.MOVING_LEFT)
		emit_signal("left_arrow", "default", false)

func _on_Drop_area_entered(area):
	if _state == States.MOVING_LEFT:
		position.x = 106
		_change_state(States.HOLD)
		emit_signal("left_arrow", "default", true)
		emit_signal("grab_button", "default", true)
		$Grab.play("Grab")
		yield($Grab, "animation_finished")
		$Grab.stop()
		emit_signal("drop")
		_grabbed = false		
		$Grab.play("Grab", true)
		yield($Grab, "animation_finished")
		$Grab.stop()
		if (_lose_token):
			emit_signal("lose_token", tokens)
			tokens = Global.lose_token()
			_lose_token = false
			if tokens == 0:
				game_over_node.popup()
		_change_state(States.STOPPED)

func _on_RightBounds_area_entered(area):
	if _state == States.MOVING_RIGHT:
		_change_state(States.MOVING_LEFT)
		emit_signal("right_arrow", "default", true)
		emit_signal("left_arrow", "default", false)

func _on_Bottom_area_entered(area):
	if area.name == "Claw":
		_change_state(States.MOVING_UP)

func _change_state(var state):
	_state = state
	print(States.keys()[state])



