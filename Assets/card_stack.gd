class_name CardStack
extends Node

@export var max_slots:int = 7

var cards:Array[Card] = []

func discard()->Array[Card]:
	var return_cards = cards
	cards = []
	return return_cards

func add_card(card:Card)->void:
	cards.append(card)

func pop_card(card:Card)->Card:
	return null

func has_free_slot_for(_card:Card)->bool:
	return max_slots >= cards.size()
