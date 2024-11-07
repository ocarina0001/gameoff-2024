extends Node2D

@export var is_open: bool = false

func _ready() -> void:
	if is_open:
		$TileMapLayer.set_cell(Vector2i(0,0), 1, Vector2i(0,0))
