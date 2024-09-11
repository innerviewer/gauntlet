extends Object
class_name LineDrawer

#func _ready() -> void: 
#	UtilsSignals.connect("draw_dotted_line", draw_dotted_line)
#	UtilsSignals.connect("draw_dotted_curve", draw_dotted_curve)


func draw_dotted_line(
	canvas_item: CanvasItem, start: Vector2, end: Vector2, 
	spacing: float, radius: float, color: Color) -> void:

	var direction = (end - start).normalized()
	var distance = start.distance_to(end)
	var num_dots = int(distance / spacing)

	for i in range(num_dots + 1):
		var dot_position = start + direction * i * spacing
		canvas_item.draw_circle(dot_position, radius, color)

	
func draw_dotted_curve(
	canvas_item: CanvasItem, start: Vector2, end: Vector2,
	angle: float, spacing: float, radius: float, color: Color) -> void:

	# If angle is 0, draw a straight dotted line
	if angle == 0:
		draw_dotted_line(canvas_item, start, end, spacing, radius, color)
		return

	# Calculate the middle point between start and end
	var mid_point = (start + end) / 2

	# Calculate the perpendicular direction (normal) based on the angle
	var direction = (end - start).normalized()
	var normal = Vector2(-direction.y, direction.x)  # Perpendicular vector

	# Adjust the control point based on the angle
	var distance = start.distance_to(end)
	var angle_offset = distance / 4.0  # Adjust for how far the curve bends
	var control_point = mid_point + normal.rotated(deg_to_rad(angle)) * angle_offset

	# Draw the dotted curve using Bézier interpolation
	var num_dots = int(distance / spacing)
	for i in range(num_dots + 1):
		var t = float(i) / float(num_dots)
		var point_on_curve = quadratic_bezier(start, control_point, end, t)
		canvas_item.draw_circle(point_on_curve, radius, color)

# Helper function to interpolate a quadratic Bézier curve
func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var inv_t = 1.0 - t
	return inv_t * inv_t * p0 + 2.0 * inv_t * t * p1 + t * t * p2
