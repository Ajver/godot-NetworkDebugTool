extends AbstractRequestDetailsPreview

@onready var url_label = %UrlLabel
@onready var method_label = %MethodLabel
@onready var status_label = %StatusLabel
@onready var request_timestamp_label = %RequestTimestampLabel
@onready var response_timestamp_label = %ResponseTimestampLabel
@onready var request_headers_container = %RequestHeadersContainer
@onready var response_headers_container = %ResponseHeadersContainer
@onready var request_body_label = %RequestBodyLabel
@onready var response_body_label = %ResponseBodyLabel
@onready var response_texture_rect = %ResponseTextureRect
@onready var no_response_yet_label = %NoResponseYetLabel
@onready var response_tab = %ResponseTab

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
	request_body_label.text = _get_body_text(_details.request_body)
	
	_fill_headers_container(response_headers_container, _details.response_headers)
	_fill_headers_container(request_headers_container, _details.request_headers)
	
	_update_response_ui()


func _fill_headers_container(container: Control, headers: PackedStringArray) -> void:
	for c in container.get_children():
		c.queue_free()
	
	for header in headers:
		var header_label = Label.new()
		header_label.text = header
		container.add_child(header_label)

func _update_response_ui() -> void:
	if _details.status_code == -1:
		# no response yet
		response_tab.hide()
		no_response_yet_label.show()
		return
	
	response_tab.show()
	no_response_yet_label.hide()
	
	var content_type = _details.get_response_header_value("Content-type")
	
	if content_type.begins_with("image/"):
		response_texture_rect.texture = _load_image_from_response(content_type)
	else:
		response_body_label.text = _get_body_text(_details.response_body)


func _load_image_from_response(img_type: String) -> Texture2D:
	var buffer = _details.response_body
	
	var image = Image.new()
	
	if img_type == "image/jpeg":
		image.load_jpg_from_buffer(buffer)
	elif img_type == "image/png":
		image.load_png_from_buffer(buffer)
	elif img_type == "image/bmp":
		image.load_bmp_from_buffer(buffer)
	elif img_type.begins_with("image/svg"):
		image.load_svg_from_buffer(buffer)
	elif img_type == "image/webp":
		image.load_webp_from_buffer(buffer)
	else:
		# Unsupported image type
		return null
	
	var texture = ImageTexture.create_from_image(image)
	return texture


func _get_body_text(body) -> String:
	if body is String:
		if body.is_empty():
			return "<empty body>"
		
		var parser = JSON.new()
		var error = parser.parse(body)
		
		if error != OK:
			return body
		
		var beautified_json = JSON.stringify(parser.data, "\t")
		return beautified_json
	
	if body is PackedByteArray:
		var text = body.get_string_from_utf8()
		return _get_body_text(text)
	
	return "<can't parse body>"
