extends Camera2D

## The thing for the camera to follow.
@export var target: Node2D
## The smoothness of the lean of the camera.
@export var smooth_lean := 25
## The scale at which the camera leans.
@export var scale_lean : float = 0.1
## The max zoom level
@export var max_zoom : float = 2
## The minimum zoom level
@export var min_zoom : float = 1
## The zoom factor to control how much zoom changes based on mouse distance
@export var zoom_factor : float = 0.01

func lean_to_mouse(delta: float):
	var mouse_position := get_local_mouse_position()
	var lean := (mouse_position - position) * scale_lean
	offset = lerp(offset, lean, delta * smooth_lean)

func update_zoom():
	var mouse_position := get_global_mouse_position()
	var target_position := target.global_position
	var distance := mouse_position.distance_to(target_position)
	var adjusted_distance := sqrt(distance) 
	var new_zoom = clamp(max_zoom - (adjusted_distance * zoom_factor), min_zoom, max_zoom)
	zoom = Vector2(new_zoom, new_zoom)

func _process(delta: float) -> void:
	lean_to_mouse(delta)
	update_zoom()
	global_rotation = 0
