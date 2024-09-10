extends Object

func draw_dotted_line(canvas_item: CanvasItem, start: Vector2, end: Vector2, 
						spacing: float, radius: float, color: Color) -> void:

	var direction = (end - start).normalized()
	var distance = start.distance_to(end)
	var num_dots = int(distance / spacing)

	for i in range(num_dots + 1):
		var dot_position = start + direction * i * spacing
		canvas_item.draw_circle(dot_position, radius, color)
