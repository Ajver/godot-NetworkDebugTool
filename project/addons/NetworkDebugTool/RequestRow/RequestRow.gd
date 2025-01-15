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
	_details.data_updated.connect(_update_data)
	_update_data()


func _update_data() -> void:
	var url: String = _details.url
	var ds_idx = url.find("//")
	
	if ds_idx != -1:
		name_label.text = url.substr(ds_idx + 2)
	else:
		name_label.text = url
	
	if _details.status_code == -1:
		status_label.text = "pending"
	else:
		status_label.text = str(_details.status_code)
	


func _on_pressed() -> void:
	pressed.emit(_details)
