extends Actor

func _ready() -> void:
	SignalEvents.quest_phase_completed.connect(_on_quest_phase_completed)

func _on_quest_phase_completed(quest_id: int, completed_phase: int) -> void:
	if quest_id == 0: dialogue_node.set_idx = completed_phase + 1
