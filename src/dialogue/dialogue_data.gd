class_name DialogueData
extends Resource

@export var speaker: String
@export var sequences: Array[DialogueSequenceData] = []

func get_dialogue(seq_idx:int, entry_idx:int) -> Dialogue:
	var d := Dialogue.new()
		
	if not sequences.is_empty() and sequences.size() > seq_idx:
		if entry_idx < sequences[seq_idx].entries.size():
			var entry_data: DialogueSequenceEntryData = \
				sequences[seq_idx].entries[entry_idx]

			if entry_data is DialogueSequenceChoiceData:
				d = DialogueChoice.new()
				d.choices = entry_data.choices

			d.text = entry_data.text
	return d
