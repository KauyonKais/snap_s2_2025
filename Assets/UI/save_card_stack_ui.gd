class_name SaveCardStackUI
extends CardStackUI

func add_card(card: Card) -> void:
	super.add_card(card)
	open_slots -= 1

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	super._on_card_ui_reparent_requested(child)
	
