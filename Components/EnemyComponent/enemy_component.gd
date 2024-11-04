extends Node2D

# This code should handle the following:
# Health, Armor, Oxygen (if we choose to track oxygen)
# Damage output (will modify a DamageComponent)
# Movement speed, pathfinding, and basic AI
# If we need more advanced AI, we can write specific scripts for the enemies.

## The health of the enemy.
@export var health: float = 100
var current_health:float
## The armor of the enemy.
@export var armor: float = 100
var current_armor:float
## The oxygen of the enemy.
@export var oxygen: float = 100
var current_oxygen:float
## Flags whether or not the enemy requires oxygen.
@export var has_oxygen: bool = true
## The damage its main attack does.
@export var damage: float = 25
## The speed of the enemy.
@export var speed: float = 100
## The vision range of the enemy.
@export var vision: float = 80
var target: Node2D
var parent: Node2D

func _ready() -> void:
	current_armor = armor
	current_health = health
	current_oxygen = oxygen
	parent = get_parent()
	$VisionArea/CollisionShape2D.shape.radius = vision

func _physics_process(delta: float):
		var direction : Vector2
		if not $NavigationAgent2D.is_navigation_finished():
			direction = ($NavigationAgent2D.get_next_path_position() - parent.global_position).normalized()
			parent.velocity = direction * speed
			parent.move_and_slide()
			parent.look_at(target.global_position)
		else:
			parent.velocity = Vector2.ZERO

func create_path():
	if target != null:
		$NavigationAgent2D.target_position = target.global_position

func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		target = body

func _on_timer_timeout() -> void:
	create_path()
