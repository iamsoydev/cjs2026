class_name InteractionNode
extends Area2D

signal interaction_occured(npath: NodePath)

## { [interaction type name] : [target node path]
@export var interaction_targets: Dictionary[String, NodePath] = {}

func _ready() -> void:
	add_to_group("interaction_nodes")

func interact(interacting_npath: NodePath) -> void:
	
	interaction_occured.emit(get_node(interaction_targets["dialogue"]).get_path())
	# How do we get the node that contains the relevant data?
	#SignalEvents.interaction_attempted.emit(InteractionType.DIALOGUE, owner.get_path(), interacting_npath)
