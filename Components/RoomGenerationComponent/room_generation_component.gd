extends Node2D

# This script should take in a list of rooms
# and then determine the best rooms to generate at any given time

## The list of rooms to generate. WARNING: Rooms should only be added to this list on the INSTANTIATED NODE.
@export var rooms_to_generate: Array[PackedScene]
