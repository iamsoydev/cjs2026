extends Actor

var quest_node: Node

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 0:
		quest_node.complete('q1','talk_to_kyle')
