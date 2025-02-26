extends Node


@export var start_deck:CardPile
@export var start_slots:int
var deck:CardPile
var discard:CardPile
var slots:int
var gold:int


func apply_outcome(outcome:ChallengeOutcome)->void:
	gold += outcome.gold
	slots -= outcome.burn_slots
	#TODO handle card burning
