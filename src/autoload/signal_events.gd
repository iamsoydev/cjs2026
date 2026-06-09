extends Node

signal ui_dialogue_visibility_change_requested(is_visible: bool)
signal ui_dialogue_present_requested(dialogue: DialogueData)
signal ui_dialogue_end_requested
signal ui_dialogue_next_segment_requested

signal interaction_attempted(
	interacting_npath: NodePath,
	interacted_npath: NodePath,
	source_npath: NodePath)
signal interaction_started
signal interaction_ended

#TODO: This is ugly... but it works
signal player_disable_interaction_requested()
signal player_enable_interaction_requested()
