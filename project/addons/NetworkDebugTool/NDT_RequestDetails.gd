extends RefCounted
class_name NDT_RequestDetails

signal data_updated


var url: String
var method: HTTPClient.Method
var status_code: int = -1
var request_timestamp: String
var response_timestamp: String = "-"
var http_req_error: Error

var response_headers: PackedStringArray
var response_body: PackedByteArray


func get_method_as_string() -> String:
	return {
		HTTPClient.Method.METHOD_GET: "GET",
		HTTPClient.Method.METHOD_POST: "POST",
		HTTPClient.Method.METHOD_PUT: "PUT",
		HTTPClient.Method.METHOD_DELETE: "DELETE",
		HTTPClient.Method.METHOD_OPTIONS: "OPTIONS",
		HTTPClient.Method.METHOD_TRACE: "TRACE",
		HTTPClient.Method.METHOD_CONNECT: "CONNECT",
		HTTPClient.Method.METHOD_PATCH: "PATCH",
	}[method]
