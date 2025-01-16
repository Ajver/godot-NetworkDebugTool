extends Node


func _ready() -> void:
	print("Demo")
	
	await get_tree().create_timer(0.7).timeout
	_make_request()
	
	_download_some_images()
	
	await get_tree().create_timer(5.7).timeout
	_make_request()


func _make_request() -> void:
	var req: NDT_HttpRequest = NDT_HttpRequest.new()
	add_child(req)
	req.request("https://genrandom.com/api/cat")


func _download_some_images() -> void:
	_get_req("https://freepngimg.com/static/img/youtube.png")
	_get_req("https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Rotating_earth_%28large%29.gif/200px-Rotating_earth_%28large%29.gif")
	_get_req("https://people.math.sc.edu/Burkardt/data/bmp/blackbuck.bmp")
	_get_req("https://upload.wikimedia.org/wikipedia/commons/3/3f/JPEG_example_flower.jpg?20170304154031")
	_get_req("https://imgs.search.brave.com/o9NGff11t95zJb2xoDHqY6Lh4bjC5vetCv8x6veupG0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZWVrc2Zvcmdl/ZWtzLm9yZy93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyNDA2MTkx/ODAzNTUvY29sb3It/aW1hZ2Uud2VicA")
	_get_req("https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/Steps.svg")


func _get_req(url: String) -> void:
	var req = NDT_HttpRequest.new()
	add_child(req)
	req.request(url)
