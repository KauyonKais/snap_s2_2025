class_name CardStackUI
extends HBoxContainer

const CARD_UI_SCENE := preload("res://Assets/CardUI/card_ui.tscn")

@export var max_slots:int = 7

func add_card(card: Card) -> void:
	var new_card_ui := CARD_UI_SCENE.instantiate() as CardUI
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card

func get_used_slots() -> int:
	var count := 0
	for child in get_children():
		if child.card:
			count += 1
	return count

func discard_card(card: CardUI) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card: CardUI in get_children():
		card.disabled = true

func has_free_slot_for(_card:CardUI)->bool:
	return max_slots >= get_used_slots()

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	var parent:CardStackUI
	if child.new_parent and child.new_parent.has_free_slot_for(child): parent = child.new_parent
	else: parent = child.parent
	child.change_parent(parent)
	parent.add_card_to_position(child)
	child.set_deferred("disabled", false)

func add_card_to_position(card_ui:CardUI) -> void:
	var new_index := clampi(card_ui.original_index, 0, get_child_count())
	move_child.call_deferred(card_ui, new_index)
