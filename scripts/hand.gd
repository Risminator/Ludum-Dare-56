extends CharacterBody2D

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
var food: Global.FOOD = Global.FOOD.CARROT
var is_animal_satisfied: bool = false

func _ready() -> void:
	animation_player.play("{food} {health} hp".format({"food":food, "health":hp}))
	Events.game_start.connect(_on_game_start)
	Events.satisfied_animal.connect(_on_satisfied)
	#Events.chomp_successful.connect(_on_chomp_successful)
	

func _physics_process(_delta: float) -> void:
	get_keyboard_input()
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
		if is_animal_satisfied:
			if animal != null:
				if get_slide_collision_count() > 0:
					animal.gpu_particles_2d.amount = 8
				else:
					animal.gpu_particles_2d.amount = 2
		elif get_slide_collision_count() > 0:
			get_hurt()
		
		#if animal != null and is_animal_satisfied:
			#if get_slide_collision_count() > 0:
				#if animal.gpu_particles_2d != null:
					#animal.gpu_particles_2d.amount = 8
			#else:
				#if animal.gpu_particles_2d != null:
					#animal.gpu_particles_2d.amount = 2
			
		if position.x < min_x:
			position.x = min_x

func get_keyboard_input() -> void:
	if Input.is_action_just_pressed("1"):
		food = Global.FOOD.CARROT
	if Input.is_action_just_pressed("2"):
		food = Global.FOOD.MEAT
	if Input.is_action_just_pressed("3"):
		food = Global.FOOD.APPLE
	if Input.is_action_just_pressed("4"):
		food = Global.FOOD.MANDRAKE
	if Input.is_action_just_pressed("5"):
		food = Global.FOOD.FISH

func get_hurt() -> void:
	animation_player.play("hurt")
	animal.flee()

func _on_game_start() -> void:
	is_controllable = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(4):
		hp -= 1
		animation_player.play("{food} {health} hp".format({"food":food, "health":hp}))
		if hp <= 0:
			Events.satisfied_animal.emit()
			print($Sprite2D.frame)

func _on_satisfied() -> void:
	min_x = -300
	is_animal_satisfied = true
