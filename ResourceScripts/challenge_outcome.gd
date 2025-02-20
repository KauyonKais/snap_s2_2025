class_name ChallengeOutcome
extends Resource

@export var title:String
@export var is_positive:bool

@export_category("Positive")
@export var gold_coins:int
@export_category("Negative")
@export var burn_cards:int
@export var burn_slots:int
