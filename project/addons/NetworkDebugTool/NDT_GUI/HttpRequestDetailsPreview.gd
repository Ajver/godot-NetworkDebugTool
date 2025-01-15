extends AbstractRequestDetailsPreview

@onready var url_label = %UrlLabel
@onready var method_label = %MethodLabel
@onready var status_label = %StatusLabel
@onready var request_timestamp_label = %RequestTimestampLabel
@onready var response_timestamp_label = %ResponseTimestampLabel

var _details: NDT_RequestDetails


func preview_details(details: NDT_RequestDetails) -> void:
	_details = details
	details.data_updated.connect(_update_data)
	_update_data()


func _update_data() -> void:
	url_label.text = _details.url
	method_label.text = _details.get_method_as_string()
	status_label.text = str(_details.status_code)
	request_timestamp_label.text = _details.request_timestamp
	response_timestamp_label.text = _details.response_timestamp
