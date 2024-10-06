class_name Animal
extends StaticBody2D

@onready var animations: AnimationPlayer = $Animations
@onready var state_machine: Node = $StateMachine
@onready var calm_timer: Timer = $CalmTimer
@onready var chomp_timer: Timer = $ChompTImer
@onready var cooldown_timer: Timer = $CooldownTimer

@onready var touch_collider: Area2D = $TouchCollider
@onready var touch_polygon: CollisionPolygon2D = $TouchCollider/TouchPolygon

@onready var feed_collider: Area2D = $FeedCollider2
@onready var physical_collider: CollisionPolygon2D = $PhysicalCollider

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func flee():
	animations.play("flee")
