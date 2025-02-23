extends Node2D

@onready var challenge_handler:ChallengeHandler = $ChallengeHandler

#to be moved to player
@onready var hand = $CanvasLayer/Hand
@onready var save = $CanvasLayer/Save
@onready var play = $CanvasLayer/Play
@export var start_deck:CardPile
@export var start_slots:int
@export var challenges = [Challenge]
var deck:CardPile
var discard:CardPile
var slots:int
var gold:int
const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

#to be moved
func _ready() -> void:
	slots = start_slots
	deck = start_deck.duplicate(true)
	discard = CardPile.new()
	start_day()

func start_day()->void:
	deck.shuffle()
	draw_cards(slots)
	start_turn()

func end_day() -> void:
	end_turn()
	discard_hand()

func start_turn()->void:
	challenge_handler.start_challenge(challenges.pick_random())
	pass

func end_turn()->void:
	#TODO handle challenge result
	var play_value := 0
	for card:CardUI in play.get_children():
		play_value += card.card.value
	
	var challenge_outcome := challenge_handler.get_challenge_result(play_value)
	apply_outcome(challenge_outcome)
	
	#hand.disable_hand()
	discard_play()
#to be moved to player
func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(
		func(): pass #Events.player_hand_drawn.emit()
	)
#to be moved to player
func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_card(deck.draw_card())
	reshuffle_deck_from_discard()

func apply_outcome(outcome:ChallengeOutcome)->void:
	if outcome.is_positive:
		gold += outcome.gold
	else:
		slots -= outcome.burn_slots
		#TODO handle card burning

func discard_play() -> void:
	if play.get_child_count() == 0:
		turn_ended()
		return
	
	var tween := create_tween()
	for card_ui: CardUI in play.get_children():
		tween.tween_callback(discard.add_card.bind(card_ui.card))
		tween.tween_callback(card_ui.queue_free)
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	
	tween.finished.connect(
		func():
			turn_ended()
			pass #Events.player_hand_discarded.emit()
	)

func discard_hand() -> void:
	if hand.get_child_count() == 0:
		day_ended()
		return
	
	var tween := create_tween()
	for card_ui: CardUI in hand.get_children():
		tween.tween_callback(discard.add_card.bind(card_ui.card))
		tween.tween_callback(hand.discard_card.bind(card_ui))
		tween.tween_interval(HAND_DISCARD_INTERVAL)
		
	tween.finished.connect(
		func():
			day_ended()
			pass #Events.player_hand_discarded.emit()
	)
	
func reshuffle_deck_from_discard() -> void:
	if not deck.empty():
		return

	while not discard.empty():
		deck.add_card(discard.draw_card())

	deck.shuffle()

#TODO handle better!
func _on_end_turn_pressed() -> void:
	end_turn()

func turn_ended()->void:
	start_turn()

func day_ended() -> void:
	start_day()

func _on_end_day_pressed() -> void:
	end_day()
