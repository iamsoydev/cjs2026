extends Actor

func _on_quest_node_quest_event_occured(event_type: Quest.Event, origin_id: StringName, msg: Dictionary) -> void:
	if event_type == Quest.Event.ON_ACTOR_EVENT:
		match(origin_id):
			&"q0o2_bertha_questioned": pass # TODO: Record bertha questioned

func _on_quest_objective_completed(quest_id: int, quest_objective_id: int) -> void:
	if quest_id == 0:
		if quest_objective_id == 0:
			dialogue_node.set_sequence(1)
		elif quest_objective_id == 1:
			dialogue_node.set_sequence(2)
		elif quest_objective_id == 2:
			dialogue_node.set_sequence(3)

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 1:
		SignalEvents.quest_notify_objective_completed.emit(0, 1)
