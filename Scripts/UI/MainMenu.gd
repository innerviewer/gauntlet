extends Control

@onready var start_button: TextureButton = $VBoxContainer/StartButton
@onready var settings_button: TextureButton = $VBoxContainer/SettingsButton
@onready var exit_button: TextureButton = $VBoxContainer/ExitButton

func _ready() -> void:
	start_button.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	settings_button.connect("pressed", Callable(self, "_on_SettingsButton_pressed"))
	exit_button.connect("pressed", Callable(self, "_on_ExitButton_pressed"))
	
func _on_StartButton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/devel.tscn") 

func _on_SettingsButton_pressed() -> void:
	Events.emit_signal("pause_menu_toggle", true)

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
