class_name CardState
extends Node

#State definition
enum State {IDLE, CLICKED, DRAGGING, RELEASED}
signal transition_requested(from: CardState, to: State)

#class state
@export var state:State

#references
var card_ui:CardUI

#INTERFACE
func enter() -> void:
	pass


func exit() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func on_gui_input(_event: InputEvent) -> void:
	pass


func on_mouse_entered() -> void:
	pass


func on_mouse_exited() -> void:
	pass
