extends Actor

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 0:
		dialogue_node.set_sequence(1)
