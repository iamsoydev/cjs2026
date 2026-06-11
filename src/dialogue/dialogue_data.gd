class_name DialogueData
extends Resource

@export var speaker: String
@export var sequences: Array[DialogueSequence] = []

func get_dialogue(seq_idx:int, entry_idx:int) -> Dialogue:
	var d := Dialogue.new()
	d.speaker = speaker
	
	if not sequences.is_empty() and sequences.size() > seq_idx:
		if entry_idx in sequences[seq_idx].entries:
			d.text = sequences[seq_idx].entries[entry_idx]
	return d
