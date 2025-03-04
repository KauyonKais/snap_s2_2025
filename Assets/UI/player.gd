extends Node


@export var start_deck:CardPile
@export var start_slots:int
var deck:CardPile
var discard:CardPile
var slots:int
var gold:int

func _ready() -> void:
	deck = start_deck.duplicate()
	discard = CardPile.new()
	slots = start_slots

func apply_outcome(outcome:ChallengeOutcome)->void:
	gold += outcome.gold
	slots -= outcome.burn_slots
	#TODO handle card burning
