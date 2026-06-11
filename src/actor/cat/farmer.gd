extends Actor

func _ready() -> void:
	SignalEvents.quest_phase_completed.connect(_on_quest_phase_completed)

func _on_quest_phase_completed(quest_id: int, completed_phase: int) -> void:
	if quest_id == 0: dialogue_node.set_idx = completed_phase + 1

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 0:
		dialogue_node.set_sequence(1)
