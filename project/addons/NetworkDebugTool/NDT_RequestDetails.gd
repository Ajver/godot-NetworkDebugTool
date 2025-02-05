extends RefCounted
class_name NDT_RequestDetails

signal data_updated


var url: String
var method: HTTPClient.Method
var request_body: String
var request_headers: PackedStringArray
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


func get_response_header_value(header_name: String) -> String:
	for header in response_headers:
		if header.to_lower().begins_with(header_name.to_lower()):
			var value = header.substr(header.find(":") + 1)
			return value.strip_edges()
	
	return ""


func is_image_response() -> bool:
	var content_type = get_response_header_value("Content-type")
	var is_image = content_type.begins_with("image/")
	return is_image


func load_image_from_response() -> Image:
	var img_type = get_response_header_value("Content-type")
	var image = Image.new()
	
	if img_type == "image/jpeg":
		image.load_jpg_from_buffer(response_body)
	elif img_type == "image/png":
		image.load_png_from_buffer(response_body)
	elif img_type == "image/bmp":
		image.load_bmp_from_buffer(response_body)
	elif img_type.begins_with("image/svg"):
		image.load_svg_from_buffer(response_body)
	elif img_type == "image/webp":
		image.load_webp_from_buffer(response_body)
	else:
		# Unsupported image type
		return null
	
	return image
