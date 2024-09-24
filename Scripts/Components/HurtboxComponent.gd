extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent
@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

func damage(attack:Attack)->void:
	if health_component:
		health_component.damage(attack)
		
func flash(area: Area2D) -> void:
	if area is HurtboxComponent:
		sprite.material.set("shader_parameter/flash_modifer", 1.0) 
		await get_tree().create_timer(0.1).timeout
		sprite.material.set("shader_parameter/flash_modifer", 0.0)
		
