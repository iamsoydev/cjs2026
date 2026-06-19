extends Actor

@onready var area_2d: Area2D = $Area2D

func _on_quest_completed(quest_id: int) -> void:
	if quest_id == 0:
		pass # TODO Activate his sensor

func _on_quest_objective_completed(quest_id: int, quest_objective_id: int) -> void:
	pass

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 1 or sequence_idx == 2 or sequence_idx == 3 or sequence_idx == 4:
		dialogue_node.set_sequence(0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	SignalEvents.ui_dialogue_present_requested.emit(dialogue_node.get_path())
