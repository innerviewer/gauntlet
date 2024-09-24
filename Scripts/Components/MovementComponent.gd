extends Node
class_name MovementComponent

@export var move_speed: float = 200

@onready var parent: CharacterBody2D = get_parent()

var current_tiletype: Globals.TileType = Globals.TileType.Normal
var velocity_modifiers: Dictionary = { }
var slippery_velocity: Vector2 = Vector2() # the player's last inputted movement velocity

func _ready() -> void:
	velocity_modifiers[Globals.TileType.Slippery] = 1.0
	velocity_modifiers[Globals.TileType.Sticky] = 1.0
	velocity_modifiers[Globals.TileType.Conveyor] = Vector2()

@warning_ignore("untyped_declaration")
func tile_entered(tile_type: Globals.TileType, custom_data) -> void:
	assert(custom_data is float or custom_data is Vector2, "Velocity modifier should be a float or Vector2.")
	match tile_type:
		Globals.TileType.Normal:
			return
		Globals.TileType.Sticky:
			velocity_modifiers[tile_type] = min(velocity_modifiers[tile_type], custom_data)
		Globals.TileType.Slippery:
			slippery_velocity = parent.velocity
			velocity_modifiers[tile_type] = min(velocity_modifiers[tile_type], custom_data)
		Globals.TileType.Conveyor:
			velocity_modifiers[tile_type] += custom_data
		Globals.TileType.Ladder:
			pass
			
	current_tiletype = tile_type

@warning_ignore("untyped_declaration")
func tile_exited(tile_type: Globals.TileType, custom_data) -> void:
	assert(custom_data is float or custom_data is Vector2, "Velocity modifier should be a float or Vector2.")
	match tile_type:
		Globals.TileType.Normal:
			return
		Globals.TileType.Sticky:
			velocity_modifiers[tile_type] = 1.0
		Globals.TileType.Conveyor:
			velocity_modifiers[tile_type] -= custom_data
		Globals.TileType.Ladder:
			pass
			
	current_tiletype = Globals.TileType.Normal
	## FIXME: This may not work if there are several 'custom' tiles together
	## Any other ways to find out on which tile the player is standing? 

func apply_modifiers(delta: float, velocity: Vector2) -> Vector2:
	if current_tiletype != Globals.TileType.Slippery:
		if current_tiletype == Globals.TileType.Sticky: 
			velocity_modifiers[Globals.TileType.Slippery] = 1.0
		else:
			velocity_modifiers[Globals.TileType.Slippery] = min(velocity_modifiers[Globals.TileType.Slippery] + (delta * 0.01), 1.0)
	
	if velocity_modifiers[Globals.TileType.Slippery] != 1.0:
		slippery_velocity = slippery_velocity * velocity_modifiers[Globals.TileType.Slippery]
		velocity = slippery_velocity
		return velocity 
	
	@warning_ignore("untyped_declaration")
	for modifier in velocity_modifiers.values():
		if modifier is float:
			velocity *= modifier
		elif modifier is Vector2:
			velocity += modifier
			
	return velocity
