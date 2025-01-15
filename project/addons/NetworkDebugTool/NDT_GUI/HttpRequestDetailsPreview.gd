extends AbstractRequestDetailsPreview

@onready var url_label = %UrlLabel
@onready var method_label = %MethodLabel
@onready var status_label = %StatusLabel
@onready var request_timestamp_label = %RequestTimestampLabel
@onready var response_timestamp_label = %ResponseTimestampLabel


func preview_details(details: NDT_RequestDetails) -> void:
	url_label.text = details.url
	method_label.text = details.get_method_as_string()
	status_label.text = str(details.status_code)
	request_timestamp_label.text = details.request_timestamp
	response_timestamp_label.text = details.response_timestamp
