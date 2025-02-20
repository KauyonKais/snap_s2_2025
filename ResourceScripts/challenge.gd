class_name Challenge
extends Resource

enum DangerLevel{LOW, MEDIUM, HIGH}
#HIGH burns slots, MEDIUM burns cards, LOW excludes good outcome

@export var title:String
@export_range(1,20) var target:int
@export var danger:DangerLevel

@export var good_outcome:ChallengeOutcome
@export var bad_outcome:ChallengeOutcome

func determine_outcome(card_value:int)->ChallengeOutcome:
	if card_value < target:
		return bad_outcome
	else:
		return good_outcome
