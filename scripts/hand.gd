extends CharacterBody2D

@export var max_speed = 1000.0
@export var wobble_speed = 20.0
@export var min_x = 0
@export var speed_limit = 600.0
@export var scare_limit_x = 620

var is_controllable = false
var rng = RandomNumberGenerator.new()

@onready var own_food_collsion = $FoodHandCollision
@onready var food_collision = $Area2D/FoodCollision

func _ready() -> void:
	own_food_collsion.shape = food_collision.shape
	own_food_collsion.position = food_collision.position
	Events.game_start.connect(_on_game_start)

func _physics_process(_delta: float) -> void:
	own_food_collsion.shape = food_collision.shape
	if is_controllable:
		var mouse_pos: Vector2 = get_global_mouse_position()
		var mouse_speed: float = Input.get_last_mouse_velocity().length()
		var mouse_distance: float = position.distance_to(mouse_pos)
		var speed: float = min(mouse_distance / 0.1, max_speed)
		
		if mouse_speed > speed_limit and position.x < scare_limit_x and velocity.x < 0:
			Events.speed_limit_reached.emit()
		
		var direction: Vector2
		if position.distance_to(mouse_pos) < 10:
			speed = wobble_speed
			direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()
		else:
			direction = position.direction_to(mouse_pos)
		velocity = speed * direction
		move_and_slide()
		if position.x < min_x:
			position.x = min_x

func _on_game_start():
	is_controllable = true
