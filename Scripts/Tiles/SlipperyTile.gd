extends Node2D

@export var friction: float = 0.5


func _on_body_entered(body: Node2D) -> void:
	if 'movement_component' in body:
		body.movement_component.tile_entered(Globals.TileType.Slippery, friction)
	else:
		print("DEBUG: not movable body on the conveyor tile.")
		
		
func _on_body_exited(body: Node2D) -> void: 
	if 'movement_component' in body:
		body.movement_component.tile_exited(Globals.TileType.Slippery, friction)
