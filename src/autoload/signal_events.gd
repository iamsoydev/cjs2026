extends Node

signal ui_dialogue_visibility_change_requested(is_visible: bool)
signal ui_dialogue_present_requested(dialogue: DialogueData)
signal ui_dialogue_present_ended
signal ui_dialogue_end_requested
signal ui_dialogue_next_segment_requested

signal dialogue_initiated(dialogue_node_npath: NodePath)

signal quest_phase_completed(quest_id: int, completed_phase: int)
signal quest_phase_started(quest_id: int, started_phase: int)
signal quest_completed(quest_id: int)
signal quest_started(quest_id: int)

signal interaction_attempted(interaction_properties: InteractionProperties)
signal interaction_started
signal interaction_ended

#TODO: This is ugly... but it works
signal player_disable_interaction_requested()
signal player_enable_interaction_requested()
