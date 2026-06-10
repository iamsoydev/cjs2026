class_name DialogueNode
extends Node

@export var dialogue_set: Array[DialogueData] = []

var set_idx: int = 0

func get_current_dialogue_set() -> DialogueData:
	return dialogue_set[set_idx]

func get_dialogue() -> DialogueData:
	return dialogue_set[set_idx]

func init_dialogue() -> void:
	SignalEvents.ui_dialogue_present_requested.emit(dialogue_set[set_idx])
	# TODO: How do we determine when the dialogue presenting is over? 
