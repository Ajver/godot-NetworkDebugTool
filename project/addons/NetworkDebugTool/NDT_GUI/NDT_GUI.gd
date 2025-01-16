extends Window

@export var RequestRowScene: PackedScene
@export var HttpRequestDetailsPreviewScene: PackedScene

@onready var invert_search_btn = %InvertSearchBtn
@onready var filter_line_edit = %FilterLineEdit
@onready var clear_logs_btn = %ClearLogsBtn

@onready var requests_list_container: VBoxContainer = %RequestsListContainer
@onready var req_details_container = %RequestDetailsContainer

var _preview: AbstractRequestDetailsPreview = null


func _init() -> void:
	hide()
	force_native = true
	
	close_requested.connect(queue_free)


func _ready() -> void:
	invert_search_btn.toggled.connect(_filter)
	filter_line_edit.text_changed.connect(_filter)
	clear_logs_btn.pressed.connect(_clear_logs)
	
	popup_centered()


func _filter(_v=null) -> void:
	# Always set the filter text, because sometimes this callback is called
	# from invert_search_btn being toggled, and the 'text' is not filled
	
	for row in requests_list_container.get_children():
		row.visible = _matches_filter(row.get_details())


func _clear_logs() -> void:
	NetworkDebugTool.clear_requests_list()
	
	for row in requests_list_container.get_children():
		row.queue_free()


func set_requests(req_list: Array[NDT_RequestDetails]) -> void:
	for details in req_list:
		new_request(details)


func new_request(details: NDT_RequestDetails) -> void:
	var row = RequestRowScene.instantiate()
	requests_list_container.add_child(row)
	row.pressed.connect(_on_row_pressed)
	row.setup(details)
	
	row.visible = _matches_filter(details)


func _matches_filter(details: NDT_RequestDetails) -> bool:
	var filter_text: String = filter_line_edit.text
	
	if filter_text.is_empty():
		return true
	
	var inverted: bool = invert_search_btn.button_pressed
	
	if details.url.contains(filter_text):
		return not inverted
	if details.get_method_as_string().contains(filter_text):
		return not inverted
	if str(details.status_code).contains(filter_text):
		return not inverted
	
	return inverted


func _on_row_pressed(details: NDT_RequestDetails) -> void:
	if is_instance_valid(_preview):
		_preview.queue_free()
	
	_preview = HttpRequestDetailsPreviewScene.instantiate()
	req_details_container.add_child(_preview)
	_preview.preview_details(details)
