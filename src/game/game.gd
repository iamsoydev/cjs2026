extends Node


#TODO: Delegate interactions
 
func _ready() -> void:
	SignalEvents.interaction_attempted.connect(_on_interaction_attempted)

func _on_interaction_attempted(interaction_props: InteractionProperties):
	if interaction_props.interaction_type == InteractionProperties.InteractionType.DIALOGUE:
		var inode: InteractionNode = get_node_or_null(interaction_props.interaction_node_npath)  
		var dia_node: DialogueNode = get_node_or_null(interaction_props.interaction_target_npath)
		SignalEvents.player_disable_interaction_requested.emit()
		if inode and dia_node:
			SignalEvents.ui_dialogue_present_requested.emit(dia_node.get_current_dialogue_set())
			await SignalEvents.ui_dialogue_present_ended
			await get_tree().create_timer(0.1).timeout
			SignalEvents.player_enable_interaction_requested.emit()
