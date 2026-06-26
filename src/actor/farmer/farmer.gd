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

func _on_dialogue_node_dialogue_entry_reached(dialogue_id: StringName, entry_idx: int) -> void:
	print(dialogue_id + " " + str(entry_idx))
