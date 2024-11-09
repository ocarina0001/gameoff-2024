extends Node2D

## Determines whether or not the door is open. If the door is open, it connects to another room.
@export var is_forced_open: bool = false
var is_open: bool
var starting_room: Node2D # This gets set to get_parent()
var connecting_room: Node2D # This gets programatically assigned

func _ready() -> void:
	starting_room = get_parent()
	#if randi_range(0, 1) == 0:
		#is_open = true
	if is_forced_open:
		is_open = true
	if is_open:
		$DoorFrame.set_cell(Vector2i(0,0), 1, Vector2i(0,0))

func _on_teleporter_body_entered(body: Node2D) -> void:
	if body.name == "player" and connecting_room != null:
		print("teleporting")
		body.position = connecting_room.position
