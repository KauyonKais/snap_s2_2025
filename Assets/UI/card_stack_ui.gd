class_name CardStackUI
extends HBoxContainer


const CARD_UI_SCENE := preload("res://Assets/CardUI/card_ui.tscn")



func add_card(card: Card) -> void:
	var new_card_ui := CARD_UI_SCENE.instantiate() as CardUI
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card


func discard_card(card: CardUI) -> void:
	card.queue_free()


func disable_hand() -> void:
	for card: CardUI in get_children():
		card.disabled = true


func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	var parent:= self as Container
	if child.new_parent: parent = child.new_parent
	print(child.new_parent)
	child.reparent(parent)
	var new_index := clampi(child.original_index, 0, parent.get_child_count())
	parent.move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
