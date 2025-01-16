extends TextureButton

@export var normal_color: Color
@export var hover_color: Color


func _ready() -> void:
	mouse_entered.connect(_on_copy_btn_mouse_entered)
	mouse_exited.connect(_on_copy_btn_mouse_exited)
	_on_copy_btn_mouse_exited()  # reset


func _on_copy_btn_mouse_entered() -> void:
	modulate = Color(hover_color)


func _on_copy_btn_mouse_exited() -> void:
	modulate = Color(normal_color)
