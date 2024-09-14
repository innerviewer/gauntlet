extends Node

@onready var window_mode_button: OptionButton = $Control/MarginContainer/VBoxContainer/WindowMode
@onready var vsync_button: CheckButton = $Control/MarginContainer/VBoxContainer/VSync

var WindowModes: Array = [
	"Fullscreen", 
	"Windowed",
	"Borderless"
]

func _ready() -> void:
	if DisplayServer.window_get_vsync_mode(DisplayServer.MAIN_WINDOW_ID) == DisplayServer.VSYNC_ENABLED:
		vsync_button.button_pressed = true
	else:
		vsync_button.button_pressed = false
		
			
	#DisplayServer.window_set_mode()

func _on_window_mode_item_selected(_index: int) -> void:
	pass
	
func _vsync_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED, DisplayServer.MAIN_WINDOW_ID)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED, DisplayServer.MAIN_WINDOW_ID)
