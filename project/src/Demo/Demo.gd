extends Node


func _ready() -> void:
	print("Demo")
	
	await get_tree().create_timer(0.7).timeout
	
	_make_request()


func _make_request() -> void:
	var req: NDT_HttpRequest = NDT_HttpRequest.new()
	add_child(req)
	req.request("https://genrandom.com/api/cat")
	
