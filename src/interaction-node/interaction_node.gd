class_name InteractionNode
extends Area2D

enum InteractionType { DIALOGUE }

func interact(interacting_npath: NodePath) -> void:
	SignalEvents.interaction_attempted.emit(InteractionType.DIALOGUE, owner.get_path(), interacting_npath)
