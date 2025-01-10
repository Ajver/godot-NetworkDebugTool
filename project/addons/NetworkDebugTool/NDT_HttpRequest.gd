extends HTTPRequest


func _init() -> void:
	request_completed.connect(_on_request_completed)


func request(url: String, custom_headers: PackedStringArray = PackedStringArray(), method: HTTPClient.Method = 0, request_data: String = "") -> Error:
	var error = super.request(url, custom_headers, method, request_data)
	print("Making request")
	print(url)
	print(custom_headers)
	print(method)
	print(request_data)
	return error


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("REQUEST COMPLETED:")
	print(result)
	print(response_code)
	print(headers)
	print(body)
