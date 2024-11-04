extends CharacterBody2D

## The speed of the player.
@export var speed := 500
var last_direction : String
var can_move : bool = true
var is_moving: bool = false

func get_input():
	var input_dir := Input.get_vector("a", "d", "w", "s")
	velocity = input_dir * speed
	if velocity.length() != 0:
		is_moving = true
	else:
		is_moving = false

	# Animation handler using match
	#match input_dir:
		#Vector2(0, -1): # Up / North
			#animated_sprite.play("walk_north")
			#last_direction = "north"
		#Vector2(0, 1): # Down / South
			#animated_sprite.play("walk_south")
			#last_direction = "south"
		#Vector2(-1, 0): # Left / West
			#animated_sprite.play("walk_east")
			#last_direction = "east"
			#animated_sprite.flip_h = true
		#Vector2(1, 0): # Right / East
			#animated_sprite.play("walk_east")
			#last_direction = "west"
			#animated_sprite.flip_h = false
		#Vector2(0, 0): # Still
			#match last_direction:
				#"north":
					#animated_sprite.play("still_north")
				#"south":
					#animated_sprite.play("still_south")
				#"east":
					#animated_sprite.play("still_east")
					#animated_sprite.flip_h = true
				#"west":
					#animated_sprite.play("still_east")
					#animated_sprite.flip_h = false

func _physics_process(delta):
	if can_move == true:
		get_input()
		move_and_collide(velocity * delta)

func _process(delta: float) -> void:
	var direction = get_global_mouse_position() - global_position
	rotation = direction.angle()
	if is_moving == true:
		$Legs.play("moving")
	else:
		$Legs.stop()
