extends Actor

func _on_quest_node_quest_event_occured(event_type: Quest.Event, origin_id: StringName, msg: Dictionary) -> void:
	if event_type == Quest.Event.ON_COMPLETE:
		match(origin_id):
			&"q0o1_meet_kyle":
				dialogue_node.set_sequence(1)

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 1:
		dialogue_node.set_sequence(2)
		quest_node.notify_actor_event_occured(
			&"q0o2_question_cows", &"q0o2_bertha_questioned")
		SignalEvents.quest_notify_objective_completed.emit(0,2)
