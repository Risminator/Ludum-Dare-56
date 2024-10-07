extends CharacterBody2D
class_name Hand

@export var max_speed = 1000.0
@export var wobble_speed = 20.0
@export var min_x = -300
@export var speed_limit = 600.0
@export var scare_limit_x = 620

var is_controllable: bool = false
var rng = RandomNumberGenerator.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var animal: Animal

var hp: int = 3
var max_hp: int = 3
var food: Global.FOOD = Global.FOOD.CARROT
var is_animal_satisfied: bool = false

func _ready() -> void:
	animation_player.play("{food} {health} hp".format({"food":food, "health":hp}))
	Events.game_start.connect(_on_game_start)
	Events.satisfied_animal.connect(_on_satisfied)
	

func _physics_process(_delta: float) -> void:
	if is_controllable:
		if hp >= max_hp:
			get_keyboard_input()
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
		if is_animal_satisfied and animal != null:
			if get_slide_collision_count() > 0:
				animal.gpu_particles_2d.amount = 8
			else:
				animal.gpu_particles_2d.amount = 2
			
		if position.x < min_x:
			position.x = min_x

func get_keyboard_input() -> void:
	var new_food: Global.FOOD = food
	if Input.is_action_just_pressed("1"):
		new_food = Global.FOOD.CARROT
	if Input.is_action_just_pressed("2"):
		new_food = Global.FOOD.MEAT
	if Input.is_action_just_pressed("3"):
		new_food = Global.FOOD.APPLE
	if Input.is_action_just_pressed("4"):
		new_food = Global.FOOD.MANDRAKE
	if Input.is_action_just_pressed("5"):
		new_food = Global.FOOD.FISH
	if Input.is_action_just_pressed("6"):
		new_food = Global.FOOD.BERRIES
		
	if new_food != food:
		food = new_food
		animation_player.play("{food} {health} hp".format({"food":food, "health":hp}))

func get_hurt() -> void:
	Events.got_hurt.emit()
	Events.screen_shake.emit(10)
	wobble_speed = 50
	animation_player.play("hurt")
	animal.flee()

func _on_game_start() -> void:
	is_controllable = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(4):
		Events.chomp_successful.emit(food)
		Events.screen_shake.emit(5)
		if is_food_correct():
			hp -= 1
			animation_player.play("{food} {health} hp".format({"food":food, "health":hp}))
			if hp <= 0:
				Events.satisfied_animal.emit()
			print($Sprite2D.frame)
		else:
			animal.modulate = Color.DARK_OLIVE_GREEN
			animal.flee()

func is_food_correct() -> bool:
	if animal is Rabbit and food != Global.FOOD.CARROT:
		return false
	if animal is Axolotl and food != Global.FOOD.FISH:
		return false
	return true

func _on_satisfied() -> void:
	min_x = -300
	is_animal_satisfied = true
