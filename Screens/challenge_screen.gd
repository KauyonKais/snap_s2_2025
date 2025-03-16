extends Node2D

@onready var challenge_handler:ChallengeHandler = $ChallengeHandler

@onready var player = $Player

@onready var hand = $CanvasLayer/Hand
@onready var save = $CanvasLayer/Save
@onready var play = $CanvasLayer/Play
@export var challenges = [Challenge]

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

#to be moved
func _ready() -> void:
	connect_event_hub()
	start_day()

func connect_event_hub() -> void:
	EventHub.day_ended.connect(_on_day_ended)
	EventHub.day_started.connect(_on_day_started)

func start_day()->void:
	player.deck.shuffle()
	draw_cards(player.slots)
	EventHub.day_started.emit()
	start_turn()

func end_day() -> void:
	end_turn()
	player.discard_hand()

func start_turn()->void:
	challenge_handler.start_challenge(challenges.pick_random())
	pass

func end_turn()->void:
	var play_value := 0
	for card:CardUI in play.get_children():
		play_value += card.card.value
	
	var challenge_outcome := challenge_handler.get_challenge_result(play_value)
	player.apply_outcome(challenge_outcome)
	
	#hand.disable_hand()
	player.discard_play()

#TODO handle better!
func _on_end_turn_pressed() -> void:
	end_turn()

func _on_end_day_pressed() -> void:
	end_day()

####### CYCLE EVENTS
func _on_day_started()->void:
	pass

func turn_ended()->void:
	start_turn()

func _on_day_ended() -> void:
	start_day()
