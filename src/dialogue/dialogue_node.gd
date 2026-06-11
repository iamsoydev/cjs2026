class_name DialogueNode
extends Node

signal last_dialogue_entry_reached(sequence_idx: int, entry_idx: int)
signal next_dialogue_entry_reached(sequence_idx: int, entry_idx: int)
signal next_dialogue_sequence_reached(sequence_idx: int)

@export var dialogue_data: DialogueData = null

var active_seq_idx: int = 0: set = set_sequence
var active_entry_idx: int = 0

func get_next_dialogue_entry() -> Dialogue:
	if not dialogue_data: return Dialogue.new()

	active_entry_idx += 1
	var d: Dialogue
	d = dialogue_data.get_dialogue(active_seq_idx, active_entry_idx)
	if d.text.is_empty():
		last_dialogue_entry_reached.emit(active_seq_idx, active_entry_idx-1)
	else:
		next_dialogue_entry_reached.emit(active_seq_idx, active_entry_idx)
	return d

func get_active_dialogue_entry() -> Dialogue:
	var d := Dialogue.new()
	if dialogue_data:
		d = dialogue_data.get_dialogue(active_seq_idx, active_entry_idx)	
	return d

func set_sequence(seq_idx: int) -> void:
	if dialogue_data.sequences.size() > seq_idx:
		active_seq_idx = seq_idx
		next_dialogue_sequence_reached.emit(active_seq_idx)
