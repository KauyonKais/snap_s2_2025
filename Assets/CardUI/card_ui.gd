class_name CardUI
extends Node

signal reparent_requested(which_card_ui: CardUI)

@export var card:Card : set = _set_card

@onready var description:Label = $Description
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine

var original_index := 0
var parent: Control
var tween: Tween
var playable := true : set = _set_playable
var disabled := false

#OVERWRITES
func _ready() -> void:
	#connect events with outer world
	card_state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

#FUNCTIONS


func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

#SETTERS
func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	card = value
	description.text = card.id
	
func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		description.add_theme_color_override("font_color", Color.RED)
	else:
		description.remove_theme_color_override("font_color")

#EVENT HANDLERS
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()


func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
