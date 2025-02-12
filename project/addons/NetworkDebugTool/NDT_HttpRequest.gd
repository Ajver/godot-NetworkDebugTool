extends Node
class_name NDT_HttpRequest

var accept_gzip: bool = true:
	set(value): 
		accept_gzip = value
		_request.accept_gzip = value
var body_size_limit: int = -1:
	set(value): 
		body_size_limit = value
		_request.body_size_limit = value
var download_chunk_size: int = 65536:
	set(value):
		download_chunk_size = value
		_request.download_chunk_size = value
var download_file: String = "":
	set(value):
		download_file = value
		_request.download_file = value
var max_redirects: int = 8:
	set(value):
		max_redirects = value
		_request.max_redirects = value
var timeout: float = 0.0:
	set(value):
		timeout = value
		_request.timeout = value
var use_threads: bool = false:
	set(value):
		use_threads = value
		_request.use_threads = value

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


func is_accepting_gzip() -> bool:
	return accept_gzip


func get_body_size_limit() -> int:
	return body_size_limit


func get_download_chunk_size() -> int:
	return download_chunk_size


func get_download_file() -> String:
	return download_file


func get_timeout() -> float:
	return timeout


func is_using_threads() -> bool:
	return use_threads


func cancel_request() -> void:
	_request.cancel_request()


func get_body_size() -> int:
	return _request.get_body_size()


func get_downloaded_bytes() -> int:
	return _request.get_downloaded_bytes()


func get_http_client_status() -> HTTPClient.Status:
	return _request.get_http_client_status()


func set_http_proxy(host: String, port: int) -> void:
	_request.set_http_proxy(host, port)


func set_https_proxy(host: String, port: int) -> void:
	_request.set_https_proxy(host, port)


func set_tls_options(client_options: TLSOptions) -> void:
	_request.set_tls_options(client_options)
