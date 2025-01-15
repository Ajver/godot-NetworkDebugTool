extends Window

@export var RequestRowScene: PackedScene
@export var HttpRequestDetailsPreviewScene: PackedScene

@onready var requests_list_container: VBoxContainer = %RequestsListContainer
@onready var req_details_container = %RequestDetailsContainer

var _preview: AbstractRequestDetailsPreview = null


func _init() -> void:
	hide()
	force_native = true
	
	close_requested.connect(queue_free)


func _ready() -> void:
	popup_centered()


func set_requests(req_list: Array[NDT_RequestDetails]) -> void:
	for details in req_list:
		new_request(details)


func new_request(details: NDT_RequestDetails) -> void:
	var row = RequestRowScene.instantiate()
	requests_list_container.add_child(row)
	row.pressed.connect(_on_row_pressed)
	row.setup(details)


func _on_row_pressed(details: NDT_RequestDetails) -> void:
	if is_instance_valid(_preview):
		_preview.queue_free()
	
	_preview = HttpRequestDetailsPreviewScene.instantiate()
	req_details_container.add_child(_preview)
	_preview.preview_details(details)
