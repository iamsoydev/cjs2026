class_name DialogueSequence
extends Resource

var active_entry_idx := 0

@export_multiline var sequence: Array[String] = [""]

func get_active_sequence_entry() -> String:
	return sequence[active_entry_idx]

func inc_active_entry() -> void:
	active_entry_idx += 1	
