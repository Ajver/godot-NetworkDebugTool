extends Node

const _NDT_GUI_SCENE: PackedScene = preload("res://addons/NetworkDebugTool/NDT_GUI/NDT_GUI.tscn")

var _gui: Window = null

var _requests_list: Array[NDT_RequestDetails]


func append_request_details(details: NDT_RequestDetails) -> void:
	_requests_list.append(details)
	
	if _gui:
		_gui.new_request(details)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ndt_show"):
		_pop_window()


func _pop_window() -> void:
	_gui = _NDT_GUI_SCENE.instantiate()
	add_child(_gui)
	_gui.set_requests(_requests_list)
