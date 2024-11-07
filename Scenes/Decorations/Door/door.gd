extends Node2D

## Determines whether or not the door is open.
@export var is_open: bool = false

func _ready() -> void:
	if is_open:
		$TileMapLayer.set_cell(Vector2i(0,0), 1, Vector2i(0,0))
