extends Node2D

## The light that pulses slowly.
@export var light: PointLight2D
## The pace at which the light pulses.
@export var pulse_speed: float = 1.0
var energy_limit : float
var time_accumulator : float = 0.0

func _ready() -> void:
	energy_limit = light.energy

# This could probably end up being tweened
# and time_accumulator counts up forever, shouldn't be an issue but...
func _process(delta: float) -> void:
	time_accumulator += delta * pulse_speed
	light.energy = energy_limit * 0.5 * (sin(time_accumulator) + 1)
