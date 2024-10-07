class_name State
extends Node

@export var animation_name: String
@export var state_name: Global.STATES

## Hold a reference to the parent so that it can be controlled by the state
var parent: Animal

func enter() -> void:
	Events.new_animal_state.emit(state_name)
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
