extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent

@onready var shaders_component: ShaderComponent = $"../ShadersComponent"
@onready var sprite: Sprite2D = $"../Sprite2D"

func damage(attack: Attack) -> void:
	if health_component and sprite.is_in_group("Enemy"):
		health_component.damage(attack)
		shaders_component.flash_shader()
