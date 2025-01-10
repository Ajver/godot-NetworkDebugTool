extends HBoxContainer

@onready var icon_texture_rect = %IconTextureRect
@onready var name_label = %NameLabel
@onready var status_label = %StatusLabel


func setup(details: NDT_RequestDetails) -> void:
	var url: String = details.url
	var ds_idx = url.find("//")
	
	if ds_idx != -1:
		name_label.text = url.substr(ds_idx + 2)
	else:
		name_label.text = url
