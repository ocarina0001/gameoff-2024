extends Node2D

@export var rooms_to_generate: Array[PackedScene]
var level_generation_test: Node2D

# 11/8/2024
# When a room is picked, we should compare the rotation of the current door 'child'
# and then find a random door in the new room
# then rotate the room to make the door "match" the 'child' door
# and then do the stupid math shit to make the rooms connect
# and HOPEFULLY that should work.

func _ready() -> void:
	level_generation_test = get_parent().get_parent()

	for child in get_parent().get_children():
		if child.is_in_group("door") and !child.has_meta("is_assigned_to_room"):
			var random_room := rooms_to_generate[int(randi_range(0, rooms_to_generate.size() - 1))]
			var random_room_instance := random_room.instantiate()
			var new_room_door: Node2D = null
			for new_room_child in random_room_instance.get_children():
				if new_room_child.is_in_group("door") and !new_room_child.has_meta("is_assigned_to_room"):
					new_room_door = new_room_child
					child.set_meta("is_assigned_to_room", true)
					new_room_door.set_meta("is_assigned_to_room", true)
					break

			if new_room_door != null:
				var door_offset : Vector2 = child.global_position - new_room_door.global_position + Vector2(0, 32)
				random_room_instance.position += door_offset
				level_generation_test.add_child.call_deferred(random_room_instance)
