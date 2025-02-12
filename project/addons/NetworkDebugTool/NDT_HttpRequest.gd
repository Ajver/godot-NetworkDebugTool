extends Node
class_name NDT_HttpRequest

var _request: HTTPRequest
var _details: NDT_RequestDetails


func _init() -> void:
	_request = HTTPRequest.new()
	_request.request_completed.connect(_on_request_completed)
	add_child(_request)


func request(url: String, custom_headers: PackedStringArray = PackedStringArray(), method: HTTPClient.Method = 0, request_data: String = "") -> Error:
	var error = _request.request(url, custom_headers, method, request_data)
	
	_details = NDT_RequestDetails.new()
	_details.request_timestamp = Time.get_datetime_string_from_system(false, true)
	_details.request_body = request_data
	_details.request_headers = custom_headers
	_details.url = url
	_details.method = method
	_details.http_req_error = error
	
	NetworkDebugTool.append_request_details(_details)
	
	return error


func request_raw(url: String, custom_headers: PackedStringArray = PackedStringArray(), method: HTTPClient.Method = 0, request_data_raw: PackedByteArray = PackedByteArray()) -> Error:
	var error = _request.request_raw(url, custom_headers, method, request_data_raw)
	
	_details = NDT_RequestDetails.new()
	_details.request_timestamp = Time.get_datetime_string_from_system(false, true)
	_details.request_body_raw = request_data_raw
	_details.request_headers = custom_headers
	_details.url = url
	_details.method = method
	_details.http_req_error = error
	
	NetworkDebugTool.append_request_details(_details)
	
	return error


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	_details.response_timestamp = Time.get_datetime_string_from_system(false, true)
	_details.status_code = response_code
	_details.response_headers = headers
	_details.response_body = body
	_details.data_updated.emit()
