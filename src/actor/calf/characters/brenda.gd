extends Actor

func _on_quest_completed(quest_id: int) -> void:
	if quest_id == 0:
		dialogue_node.set_sequence(1)

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 1:
		dialogue_node.set_sequence(2)
		SignalEvents.quest_notify_objective_completed.emit(1,1)
