class_name DialogueData
extends Resource

var active_sequence: int = 0
@export var speaker: String
@export var sequences: Array[DialogueSequence] = []

func get_active_sequence() -> DialogueSequence:
	return sequences[active_sequence]
