extends Window

@export var RequestRowScene: PackedScene

@onready var requests_list_container: VBoxContainer = %RequestsListContainer


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
	row.setup(details)
