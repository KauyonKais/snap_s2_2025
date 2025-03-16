extends Control

func _ready() -> void:
	_show_day_start()

## SHOW AND HIDE UI

func _hide_day_screens() -> void:
	$DayStart.visible = false
	$DayPrep.visible = false
	$DayAction.visible = false
	$DayEnd.visible = false

func _show_day_start() -> void:
	_hide_day_screens()
	$DayStart.visible = true

func _show_day_prep() -> void:
	_hide_day_screens()
	$DayPrep.visible = true

func _show_day_action() -> void:
	_hide_day_screens()
	$DayAction.visible = true

func _show_day_end() -> void:
	_hide_day_screens()
	$DayEnd.visible = true

## LISTENERS
func _on_day_started_pressed() -> void:
	_show_day_prep()

func _on_day_prepped_pressed() -> void:
	_show_day_action()

func _on_end_day_chosen_pressed() -> void:
	_show_day_end()

func _on_day_ended_pressed() -> void:
	_show_day_start()
