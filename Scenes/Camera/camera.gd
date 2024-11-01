extends Camera2D

## The thing for the camera to follow.
@export var target: Node2D
## The smoothness of the lean of the camera.
@export var smooth_lean := 10
## The scale at which the camera leans.
@export var scale_lean : float = 0.2
## How much a normal zoom zooms by.
@export var zoom_ratio : float = 1
## How much a modified zoom zooms by.
@export var minor_zoom_ratio : float = 0.05
## The max zoom level
@export var max_zoom : float = 3
## The minimum zoom level
@export var min_zoom : float = 1

func lean_to_mouse(delta: float):
	var mouse_position := get_local_mouse_position()
	var lean := (mouse_position - position) * scale_lean
	offset = lerp(offset, lean, delta * smooth_lean)

func _process(delta: float) -> void:
	lean_to_mouse(delta)
	global_rotation = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift_mouse_up"):
		determine_zoom(minor_zoom_ratio, max_zoom, true)
	elif event.is_action_pressed("shift_mouse_down"):
		determine_zoom(minor_zoom_ratio, min_zoom, false)
	elif event.is_action_pressed("mouse_up"):
		determine_zoom(zoom_ratio, max_zoom, true)
	elif event.is_action_pressed("mouse_down"):
		determine_zoom(zoom_ratio, min_zoom, false)

func determine_zoom(ratio: float, threshold: int, greater_than: bool):
	var new_zoom = zoom.x + (ratio if greater_than else -ratio)
	new_zoom = clamp(new_zoom, min_zoom, max_zoom)
	zoom = Vector2(new_zoom, new_zoom)
