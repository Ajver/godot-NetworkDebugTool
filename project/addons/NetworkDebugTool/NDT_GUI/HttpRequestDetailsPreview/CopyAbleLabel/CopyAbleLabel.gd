@tool
extends HBoxContainer

@export var text: String = "" :
	get:
		return text
	set(value):
		text = value
		
		if has_node("%Label"):
			%Label.text = value


@onready var copy_btn: TextureButton = %CopyBtn


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	copy_btn.pressed.connect(_copy)
	copy_btn.hide()
	
	%Label.text = text


func _on_mouse_entered() -> void:
	copy_btn.show()


func _on_mouse_exited() -> void:
	copy_btn.hide()


func _copy() -> void:
	DisplayServer.clipboard_set(text)
