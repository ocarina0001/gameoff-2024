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
@export var damage: float = 50
## The speed of the enemy.
@export var speed: float = 100

func _ready() -> void:
	current_armor = armor
	current_health = health
	current_oxygen = oxygen
