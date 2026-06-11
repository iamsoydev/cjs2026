extends Node


#TODO: Delegate interactions
 
func _ready() -> void:
	SignalEvents.interaction_attempted.connect(_on_interaction_attempted)

func _on_interaction_attempted(type: InteractionNode.InteractionType, interacted_npath: NodePath, interacting_npath: NodePath):
		var interacted_node: Node = get_node_or_null(interacted_npath)
		var interacting_node: Node = get_node_or_null(interacting_npath)

		var dialogue_node: DialogueNode
		var player_ray_cast_2d: RayCast2D
		if interacted_node:
			if interacted_node.has_node("DialogueNode"):
				dialogue_node = interacted_node.get_node("DialogueNode")
		if interacting_node:
			if interacting_node.has_node("RayCast2D"):
				player_ray_cast_2d = interacting_node.get_node("RayCast2D")

		player_ray_cast_2d.enabled = false
		SignalEvents.ui_dialogue_present_requested.emit(dialogue_node.get_path())
		await SignalEvents.ui_dialogue_present_ended
		await get_tree().create_timer(0.1).timeout
		player_ray_cast_2d.enabled = true
