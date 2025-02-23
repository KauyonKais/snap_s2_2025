class_name ChallengeHandler
extends Node

var active_challenge:Challenge
@onready var challenge_ui:Panel = $"../CanvasLayer/Challenge"
@onready var challenge_target:Label = $"../CanvasLayer/Challenge/Target"
@onready var challenge_title:Label = $"../CanvasLayer/Challenge/Title"

func start_challenge(challenge:Challenge):
	active_challenge = challenge
	challenge_ui.visible = true
	challenge_target.text = str(active_challenge.target)
	challenge_title.text = active_challenge.title

func get_challenge_result(value:int)->ChallengeOutcome:
	return active_challenge.determine_outcome(value)

func end_challenge()->void:
	challenge_ui.visible = false
