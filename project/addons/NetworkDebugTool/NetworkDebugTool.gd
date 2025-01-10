extends Node

var _window: Window


func _ready() -> void:
	print("NDT Ready")


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ndt_show"):
		_pop_window()


func _pop_window() -> void:
	_window = Window.new()
	
	add_child(_window)
