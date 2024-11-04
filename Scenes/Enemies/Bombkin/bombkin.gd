extends CharacterBody2D

# When we make a sorta generic EnemyComponent for enemies, we will make it interact with this.

# Bombkin's unique behavior is (probably) exploding either when dead OR when close enough to the player
# I think we should use the explosion image clustered together to make an explosive effect

var is_chasing: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	if $EnemyComponent.target != null and is_chasing == false:
		is_chasing = true
		$AnimatedSprite2D.play("walk")

func _on_explosion_range_body_entered(body: Node2D) -> void:
	# If we really end up getting advanced, we could use groups and make this
	# check for "EnemyOfBombkin" or something. but for now "player" is fine.
	if body.name == "player":
		$AnimatedSprite2D.play("explode")
		#$EnemyComponent.can_move = false

func _on_animated_sprite_2d_animation_finished() -> void:
	# This should only happen on 'explode' because it doesn't loop and actually finishes.
	queue_free()
