extends Control

func _ready() -> void:
	_connect_signals()
	_show_day_start()

func _connect_signals() -> void:
	EventHub.day_ended.connect(_start_day)
	EventHub.end_day_chosen.connect(_end_day)

## BEHAVIOUR
func _start_day() -> void:
	_show_day_start()
	
func _end_day() -> void:
	_show_day_end()

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
	EventHub.day_started.emit()
	_show_day_prep()

func _on_day_prepped_pressed() -> void:
	EventHub.day_prepped.emit()
	_show_day_action()

func _on_day_ended_pressed() -> void:
	EventHub.day_ended.emit()
