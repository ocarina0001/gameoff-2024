extends Node2D

## The list of possible rooms to generate
@export var rooms_to_generate: Array[PackedScene]

func _ready() -> void:
	for door in get_parent().get_children():
		if door.is_in_group("door") and door.is_open:
			var random_room := rooms_to_generate[int(randi_range(0, rooms_to_generate.size() - 1))]
			var room_instance := random_room.instantiate()
			
			var rounded_door_rotation = round(door.rotation_degrees)
			
			if rounded_door_rotation == 270 or rounded_door_rotation == -90:
				pass
			elif rounded_door_rotation == 90:
				for child in room_instance.get_children():
					# Find the appropiate door to connect to
					if child.is_in_group("door"):
						child.is_open = true
						child.connecting_room = door
						door.connecting_room = child
						room_instance.position = Vector2(512, 512)
						break
			elif rounded_door_rotation == 0:
				pass
			elif rounded_door_rotation == 180:
				pass
			
			get_parent().get_parent().add_child.call_deferred(room_instance)
