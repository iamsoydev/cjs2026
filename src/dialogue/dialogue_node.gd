class_name DialogueNode
extends Node

signal last_dialogue_entry_reached(sequence_idx: int, entry_idx: int)
signal next_dialogue_entry_reached(sequence_idx: int, entry_idx: int)
signal next_dialogue_sequence_reached(sequence_idx: int)
signal last_dialogue_sequence_reached(sequence_idx: int)

signal dialogue_choice_made(sequence_idx: int, entry_idx: int)

@export var dialogue_data: DialogueData = null

var active_seq_idx: int = 0: set = set_sequence
var active_entry_idx: int = 0

func get_next_dialogue_entry() -> Dialogue:
	if not dialogue_data: return Dialogue.new()

	active_entry_idx += 1
	var d: Dialogue
	d = dialogue_data.get_dialogue(active_seq_idx, active_entry_idx)
	if d.text.is_empty():
		active_entry_idx = 0
		last_dialogue_entry_reached.emit(active_seq_idx, active_entry_idx-1)
	else:
		next_dialogue_entry_reached.emit(active_seq_idx, active_entry_idx)
	return d

func get_active_dialogue_entry() -> Dialogue:
	var d := Dialogue.new()
	if dialogue_data:
		d = dialogue_data.get_dialogue(active_seq_idx, active_entry_idx)	
	return d

# FIXME: This was added so that the dialogue_control can force 
# the dialogue node to emit a signal with its actuve sequence.
# Probably want to delete this later.
func get_active_dialogue_entry_idx() -> int:
	return active_entry_idx

# FIXME: This was added so that the dialogue_control can force 
# the dialogue node to emit a signal with its actuve sequence.
# Probably want to delete this later.
func get_active_sequence() -> int:
	return active_seq_idx

func set_sequence(seq_idx: int) -> void:
	if dialogue_data.sequences.size() > seq_idx:
		active_seq_idx = seq_idx
		active_entry_idx = 0
		next_dialogue_sequence_reached.emit(active_seq_idx)

func make_dialogue_choice(choice_idx: int) -> void:
	var dc: DialogueChoice = dialogue_data.get_dialogue(active_seq_idx, active_entry_idx)
	var next_seq: int = dc.choices[choice_idx].next_seq_idx
	dialogue_choice_made.emit(active_seq_idx, active_entry_idx)
	set_sequence(next_seq)
	
