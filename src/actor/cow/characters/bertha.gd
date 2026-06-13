extends Actor

func _on_quest_objective_completed(quest_id: int, quest_objective_id: int) -> void:
	if quest_id == 0:
		if quest_objective_id == 1:
			dialogue_node.set_sequence(1)

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 1:
		dialogue_node.set_sequence(2)
		SignalEvents.quest_notify_objective_completed.emit(0,2)
