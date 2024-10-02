extends Node2D
class_name ShaderComponent

@export var segments: int = 10
@export var shadow_opacity: float = 0.2
@export var shadow_color: Color = Color.DARK_GRAY
@export var shadow_mix_color: float = 1.0

@onready var character_sprite: Sprite2D = $"../Sprite2D"


func flash_shader() -> void:
	character_sprite.material.set("shader_parameter/flash_modifier", 1.0)
	await get_tree().create_timer(0.1).timeout
	character_sprite.material.set("shader_parameter/flash_modifier", 0.0)
	
func create_trail_effect(start_position: Vector2, end_position: Vector2, blink_duration: float, can_blink_callback: Callable) -> void:
	var trail_sprites: Array = []
	var interval: float = blink_duration / segments
	var step: Vector2 = (end_position - start_position) / segments
	
	for i: int in range(segments):
		var trail_sprite: Sprite2D = character_sprite.duplicate()
		get_tree().get_current_scene().add_child(trail_sprite)
		trail_sprites.append(trail_sprite)
		
		trail_sprite.global_position = start_position + (step * i)
		trail_sprite.modulate = shadow_color
		
		trail_sprite.material = trail_sprite.material.duplicate()
		
		trail_sprite.material.set("shader_parameter/mix_color", shadow_mix_color)
		trail_sprite.material.set("shader_parameter/opacity", shadow_opacity)
		
	for sprite: Sprite2D in trail_sprites:
		await get_tree().create_timer(interval).timeout
		sprite.queue_free()
	
	can_blink_callback.call(true)
