extends Control

## SHOW AND HIDE UI
func _hide_challenge_screens() -> void:
	$ChallengeAction.visible = false
	$ChallengeChoice.visible = false
	$ChallengeResult.visible = false
func _show_challenge_choice() -> void:
	_hide_challenge_screens()
	$ChallengeChoice.visible = true
func _show_challenge_action() -> void:
	_hide_challenge_screens()
	$ChallengeAction.visible = true
func _show_challenge_result() -> void:
	_hide_challenge_screens()
	$ChallengeResult.visible = true

## LISTENERS
func _on_challenge_chosen_pressed() -> void:
	EventHub.challenge_chosen.emit()
	_show_challenge_action()

func _on_challenge_action_ended_pressed() -> void:
	EventHub.challenge_action_ended.emit()
	_show_challenge_result()

func _on_challenge_finished_pressed() -> void:
	EventHub.challenge_ended.emit()
	_show_challenge_choice()
	
func _on_end_day_chosen_pressed() -> void:
	EventHub.end_day_chosen.emit()
