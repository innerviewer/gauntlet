extends Node
class_name HealthComponent

@onready var health_bar: TextureProgressBar = $HealthBar
@export  var MaxHealth :float = 100.0
var current_health: float

func _ready() -> void:
	health_bar.value = MaxHealth
	current_health = MaxHealth
	
func damage(attack:Attack)->void:
	current_health -= attack.attack_damage
	update_health_bar()
	
	if current_health <= 0:
		get_parent().queue_free()
		
func update_health_bar() -> void:
	if health_bar:
		health_bar.value = current_health
