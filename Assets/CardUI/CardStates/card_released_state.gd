extends CardState

var played: bool

func enter() -> void:
	played = false
	
	if false: #TODO check if moving to field or hand
		played = true
		#card_ui.play()


func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.IDLE)
