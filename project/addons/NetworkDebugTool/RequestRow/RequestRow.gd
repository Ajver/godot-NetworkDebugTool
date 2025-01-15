extends Panel

signal pressed

@onready var icon_texture_rect = %IconTextureRect
@onready var name_label = %NameLabel
@onready var status_label = %StatusLabel
@onready var button = %Button

var _details: NDT_RequestDetails


func _ready() -> void:
	button.pressed.connect(_on_pressed)


func setup(details: NDT_RequestDetails) -> void:
	_details = details
	
	var url: String = details.url
	var ds_idx = url.find("//")
	
	if ds_idx != -1:
		name_label.text = url.substr(ds_idx + 2)
	else:
		name_label.text = url


func _on_pressed() -> void:
	pressed.emit(_details)
