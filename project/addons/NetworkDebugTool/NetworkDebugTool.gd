extends Node

const _NDT_GUI_SCENE: PackedScene = preload("res://addons/NetworkDebugTool/NDT_GUI/NDT_GUI.tscn")

var _gui: Window


func _ready() -> void:
	print("NDT Ready")


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ndt_show"):
		_pop_window()


func _pop_window() -> void:
	_gui = _NDT_GUI_SCENE.instantiate()
	add_child(_gui)
