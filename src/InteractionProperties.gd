class_name InteractionProperties
extends RefCounted

enum InteractionType {
	DIALOGUE		
}

var interaction_type: InteractionType = InteractionType.DIALOGUE
var interaction_node_npath: NodePath  = NodePath()
var interaction_target_npath: NodePath= NodePath()
