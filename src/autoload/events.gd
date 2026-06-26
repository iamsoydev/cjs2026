class_name Events
extends Node

enum Type {
	
}

signal ui_dialogue_visibility_change_requested(is_visible: bool)
signal ui_dialogue_present_requested(dialogue_data: DialogueData)
signal ui_dialogue_present_ended
signal ui_dialogue_end_requested
signal ui_dialogue_next_segment_requested
signal ui_dialogue_choice_made(choice_text: String)

signal dialogue_initiated(dialogue_node_npath: NodePath)

signal quest_objective_completed(quest_id: int, quest_objective_id: int)
signal quest_completed(quest_id: int)
## Used by Actors to notify game of an objective completion
signal quest_notify_objective_completed(quest_id: int, quest_objective_id: int)

signal interaction_attempted(
	interaction_type: InteractionNode.InteractionType,
	interacted_npath: NodePath,
	interacting_npath: NodePath
)
signal interaction_started
signal interaction_ended

#TODO: This is ugly... but it works
signal player_disable_interaction_requested()
signal player_enable_interaction_requested()
