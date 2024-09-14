extends Node
class_name LineDrawer

@onready var canvas_item: CanvasItem = get_parent()
var start_point: Vector2
var end_point: Vector2
var angle: float = 0.0
var spacing: float = 30.0
var radius: float = 5.0
var color: Color = Color.RED
var curve_bend_distance: float = 100.0

func draw_dotted_line() -> void:
	var direction: Vector2 = (end_point - start_point).normalized()
	var distance: float = start_point.distance_to(end_point)
	var num_dots: int = int(distance / spacing)

	for i in range(num_dots + 1):
		var dot_position: Vector2 = start_point + direction * i * spacing
		canvas_item.draw_circle(dot_position, radius, color)

	
func draw_dotted_curve() -> void:
	# If angle is 0, draw a straight dotted line
	if angle == 0.0:
		draw_dotted_line()
		return

	# Calculate the middle point between start and end
	var mid_point: Vector2 = (start_point + end_point) / 2

	# Calculate the perpendicular direction (normal) based on the angle
	var direction: Vector2 = (end_point - start_point).normalized()
	var normal: Vector2 = Vector2(-direction.y, direction.x)  # Perpendicular vector

	# Adjust the control point based on the angle
	var distance: float = start_point.distance_to(end_point)
	
	var angle_offset: float = distance / curve_bend_distance * abs(angle)
	
	# Apply the angle to move the control point in the correct direction
	var control_point: Vector2 = mid_point + normal * angle_offset * sign(angle)
	
	# Draw the dotted curve using Bézier interpolation
	var num_dots: int = int(distance / spacing)
	for i in range(num_dots + 1):
		var t: float = float(i) / float(num_dots)
		var point_on_curve: Vector2 = quadratic_bezier(start_point, control_point, end_point, t)
		canvas_item.draw_circle(point_on_curve, radius, color)

# Helper function to interpolate a quadratic Bézier curve
func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var inv_t: float = 1.0 - t
	return inv_t * inv_t * p0 + 2.0 * inv_t * t * p1 + t * t * p2
