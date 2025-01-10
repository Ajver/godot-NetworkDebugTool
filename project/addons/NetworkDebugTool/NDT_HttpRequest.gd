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
	
	var details = NDT_RequestDetails.new()
	details.url = url
	details.http_req_error = error
	
	NetworkDebugTool.append_request_details(details)
	
	return error


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	#print("REQUEST COMPLETED:")
	#print(result)
	#print(response_code)
	#print(headers)
	#print(body)
	pass
