extends CharacterBody2D

@export var max_speed = 1000.0
@export var wobble_speed = 20.0
@export var min_x = -300
@export var speed_limit = 600.0
@export var scare_limit_x = 620

var is_controllable = false
var rng = RandomNumberGenerator.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var hp = 3

func _ready() -> void:
	animation_player.play("%s hp" % str(hp))
	Events.game_start.connect(_on_game_start)
	Events.satisfied_animal.connect(_on_satisfied)
	#Events.chomp_successful.connect(_on_chomp_successful)
	

func _physics_process(_delta: float) -> void:
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
		
		var areas: Array[Area2D] = $Area2D.get_overlapping_areas()
		if areas.size() > 0:
			print("AAA")
			_on_chomp_successful()

func _on_game_start():
	is_controllable = true


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#hp -= 1
	#animation_player.play("%s hp" % str(hp))
	#if hp <= 0:
		#Events.satisfied_animal.emit()
		#animation_player.play("0 hp")
		#print($Sprite2D.frame)

func _on_satisfied() -> void:
	min_x = -500
	print(hp)

func _on_chomp_successful():
	hp -= 1
	animation_player.play("%s hp" % str(hp))
	if hp <= 0:
		Events.satisfied_animal.emit()
		animation_player.play("0 hp")
		print($Sprite2D.frame)
