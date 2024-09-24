extends Node2D

@export var conveyor_speed: float = 75

@onready var conveyor_velocity: Vector2 = Vector2(cos(rotation), sin(rotation)) * conveyor_speed


func _on_body_entered(body: Node2D) -> void:
	if 'movement_component' in body:
		body.movement_component.tile_entered(Globals.TileType.Conveyor, conveyor_velocity)
	else:
		print("DEBUG: not movable body on the conveyor tile.")
		
		
func _on_body_exited(body: Node2D) -> void: 
	if 'movement_component' in body:
		body.movement_component.tile_exited(Globals.TileType.Conveyor, conveyor_velocity)
