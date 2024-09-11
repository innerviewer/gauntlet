extends Node

@onready var line_drawer : LineDrawer = preload("res://Scripts/Utils/LineDrawer.gd").new()

signal draw_dotted_line(canvas_item: CanvasItem, start: Vector2, end: Vector2, spacing: float, radius: float, color: Color)
signal draw_dotted_curve(canvas_item: CanvasItem, start: Vector2, end: Vector2, angle: float, spacing: float, radius: float, color: Color)

func _ready() -> void: 
	draw_dotted_line.connect(line_drawer.draw_dotted_line)
	draw_dotted_curve.connect(line_drawer.draw_dotted_curve)
