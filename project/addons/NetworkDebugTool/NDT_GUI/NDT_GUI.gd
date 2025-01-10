extends Window

@onready var requests_list_container: VBoxContainer = %RequestsListContainer


func _init() -> void:
	hide()
	force_native = true


func _ready() -> void:
	popup_centered()


func set_requests(req_list: Array[NDT_RequestDetails]) -> void:
	for details in req_list:
		new_request(details)


func new_request(details: NDT_RequestDetails) -> void:
	print("new req: ", details.url)
	var label = Label.new()
	label.text = details.url
	requests_list_container.add_child(label)
