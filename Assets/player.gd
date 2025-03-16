class_name Player
extends Node


@export var start_deck:CardPile
@export var start_slots:int
var deck:CardPile
var discard:CardPile
var hand:CardStack
var play:CardStack
var save:CardStack
var slots:int
var gold:int

func _ready() -> void:
	_connect_signals()
	_prepare_cards() #to be moved out of ready
	slots = start_slots

func _connect_signals() -> void:
	EventHub.day_ended.connect(_start_day)
	EventHub.end_day_chosen.connect(_end_day)
	EventHub.challenge_action_ended.connect(_end_challenge)
	
##CYCLE LISTENERS
func _start_day()->void:
	_draw_cards(slots)

func _end_challenge()->void:
	_discard_play()

func _end_day()->void:
	_discard_hand()

func _prepare_cards() -> void:
	deck = start_deck.duplicate()
	discard = CardPile.new()
	play = CardStack.new()
	hand = CardStack.new()
	save = CardStack.new()

func apply_outcome(outcome:ChallengeOutcome)->void:
	gold += outcome.gold
	slots -= outcome.burn_slots
	#TODO handle card burning

##CARDS
func _draw_cards(amount:int)->void:
	for i in range(amount):
		_draw_card()

func _discard_hand()->void:
	var discarded_cards = hand.discard()
	discard.add_cards(discarded_cards)

func _discard_play()->void:
	var discarded_cards = play.discard()
	discard.add_cards(discarded_cards)

func _draw_card()->void:
	_reshuffle_deck_from_discard()
	hand.add_card(deck.draw_card())

func _reshuffle_deck_from_discard()->void:
	if not deck.empty():
		return
	while not discard.empty():
		deck.add_card(discard.draw_card())
	deck.shuffle()
