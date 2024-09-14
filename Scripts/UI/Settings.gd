extends Node

@onready var window_mode_button: OptionButton= $Control/MarginContainer/VBoxContainer/WindowMode

var WindowModes: Array = [
	"Fullscreen", 
	"Windowed",
	"Borderless"
]

func _ready() -> void:
	Events.open_settings.connect(_on_settings_open)
	#DisplayServer.window_set_mode()

func _input(event: InputEvent) -> void:
	if self.visible and event.is_action_pressed("ui_cancel"):
		self.visible = false
		get_tree().paused = false

func _on_settings_open() -> void:
	self.visible = true
	get_tree().paused = true

func _on_window_mode_item_selected(_index: int) -> void:
	
	pass
