@tool
extends EditorPlugin

const SINGLETON_NAME := "NetworkDebugTool"
const NDT_SCRIPT := "res://addons/NetworkDebugTool/NetworkDebugTool.gd"


func _enter_tree() -> void:
	add_autoload_singleton(SINGLETON_NAME, NDT_SCRIPT)


func _exit_tree() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
