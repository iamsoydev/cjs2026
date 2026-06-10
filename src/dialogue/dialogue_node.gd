class_name DialogueNode
extends Node

@export var dialogue_set: Array[DialogueData] = []

var set_idx: int = 0

func get_current_dialogue_set() -> DialogueData:
	return dialogue_set[set_idx]
