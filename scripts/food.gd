extends CharacterBody2D

@onready var collision: CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:
	move_and_collide(Vector2.ZERO)
