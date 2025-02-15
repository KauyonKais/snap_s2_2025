class_name Hand
extends HBoxContainer

#to be moved
@export var deck:CardPile
const HAND_DRAW_INTERVAL := 0.25

const CARD_UI_SCENE := preload("res://Assets/CardUI/card_ui.tscn")

#to be moved
func _ready() -> void:
	draw_cards(5)
#to be moved
func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(
		func(): pass #Events.player_hand_drawn.emit()
	)
#to be moved
func draw_card() -> void:
	add_card(deck.draw_card())

func add_card(card: Card) -> void:
	var new_card_ui := CARD_UI_SCENE.instantiate() as CardUI
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self


func discard_card(card: CardUI) -> void:
	card.queue_free()


func disable_hand() -> void:
	for card: CardUI in get_children():
		card.disabled = true


func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	var parent:Control
	parent = self
	if child.new_parent: parent = child.new_parent
	print(child.new_parent)
	child.reparent(parent)
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
