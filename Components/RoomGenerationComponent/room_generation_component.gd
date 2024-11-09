extends Node2D

# This component MUST be placed on room scenes only. If a room is a "dead end" room
# don't bother placing it as it will take startup resources.

## The list of possible rooms to generate. This should contain pretty much every non-special room in the game.
@export var rooms_to_generate: Array[PackedScene]

func _ready() -> void:
	if Singleton.current_rooms >= Singleton.maximum_rooms:
		return
	for door in get_parent().get_children():
		if door.is_in_group("door") and door.is_open:
			var random_room := rooms_to_generate[int(randi_range(0, rooms_to_generate.size() - 1))]
			var room_instance := random_room.instantiate()
			
			var rounded_door_rotation := roundi(door.rotation_degrees)
			
			if rounded_door_rotation == -90:
				spawn_room(room_instance, door, -2048, 0)
			elif rounded_door_rotation == 90:
				spawn_room(room_instance, door, 2048, 0)
			elif rounded_door_rotation == 0:
				spawn_room(room_instance, door, 0, -2048)
			elif rounded_door_rotation == 180:
				spawn_room(room_instance, door, 0, 2048)
			

func spawn_room(room_instance: Node2D, door: Node2D, x: int, y: int):
	var opposite_rotation := (roundi(door.rotation_degrees) + 180) % 360
	if opposite_rotation == 270: # 270 and -90 are almost identical. almost. it's stupid.
		# make sure EVERY WEST-FACING DOOR IS -90.
		opposite_rotation = -90
	for child in room_instance.get_children():
		if child.is_in_group("door"):
			var child_door_rotation := roundi(child.rotation_degrees)
			print("Comparing " + str(child_door_rotation) + " and " + str(opposite_rotation))
			if child_door_rotation == opposite_rotation:
				child.is_open = true
				child.connecting_room = door
				door.connecting_room = child
				room_instance.position = Vector2(get_parent().position.x + x, get_parent().position.y + y)
				get_parent().get_parent().add_child.call_deferred(room_instance)
				Singleton.current_rooms += 1
				break
