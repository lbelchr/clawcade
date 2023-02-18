extends Line2D

var target
var point
export(NodePath) var targetPath
var draw: bool = true
var last_position
var y_direction: float = 0.0
var x_direction: float = 0.0


func _ready():
	target = get_node(targetPath)
	set_deferred("last_position", target.global_position)
func _physics_process(delta):
	point = target.global_position
	y_direction = sign(point.y - last_position.y)
	x_direction = sign(point.x - last_position.x)
	draw = point.y > 105
	
	if point.y > 105 && y_direction > 0:
		add_point(point + Vector2(0, -15))
	elif point.y > 104 && y_direction < 0:
		remove_point(get_point_count() - 1)

	if x_direction != 0:
		clear_points()
	last_position = point
	
