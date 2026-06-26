extends Actor

func _on_quest_node_quest_event_occured(
		event_type: Quest.Event, 
		origin_id: StringName, 
		msg: Dictionary
) -> void:
	if event_type == Quest.Event.ON_START:
		match(origin_id):
			&"q0o0_ask_farmer":
				pass
			&"q0o3_crop_tell":
				pass
	elif event_type == Quest.Event.ON_COMPLETE:
		match(origin_id):
			&"q0o0_ask_farmer":
				pass
			&"q0o3_crop_tell":
				pass
	elif event_type == Quest.Event.ON_ACTOR_EVENT:
		match(origin_id):
			_: pass

# TODO: Move this over to _on_quest_node_quest_event_occured
func _on_quest_objective_completed(quest_id: int, quest_objective_id: int) -> void:
	if quest_id == 0: 
		if quest_objective_id == 2:
			dialogue_node.set_sequence(2)
	elif quest_id == 1:
		if quest_objective_id == 1:
			dialogue_node.set_sequence(5)

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 0:
		dialogue_node.set_sequence(1)
		SignalEvents.quest_notify_objective_completed.emit(0,0)
	elif sequence_idx == 2:
		# TODO: Sequence is set through the choice 
		# This is very confusing and needs to be changed later.
		#dialogue.dialogue_node.set_sequence(3)
		SignalEvents.quest_notify_objective_completed.emit(0,3)
	elif sequence_idx == 3:
		dialogue_node.set_sequence(4)
		SignalEvents.quest_notify_objective_completed.emit(1,0)
