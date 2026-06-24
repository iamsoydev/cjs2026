# TODO: Should I DialogueNode be an instance of a conversation that 
# is shared by multiple characters in a single point in time?
# Perhaps the node itself is something that can initiate the dialogue
# but the dialogue system pulls in all charactes so they can be
# notified via signals.
class_name DialogueNode
extends Node

signal last_dialogue_entry_reached(sequence_idx: int, entry_idx: int)
signal dialogue_entry_reached(dialogue_id: StringName, entry_idx: int)

signal dialogue_choice_made(dialogue_id: StringName, entry_idx: int, choice_data: String)

@export var dialogue_data: DialogueData = null : set = set_dialogue_data
@onready var active_entry: DialogueEntryData

var _signal_emit_funcs: Array[Callable] = []
#var _signal_discon_funcs: Array[Callable] = []

func set_dialogue_data(data: DialogueData) -> void:
	if not _signal_emit_funcs.is_empty(): 
		#_signal_discon_funcs.all(call)
		_signal_emit_funcs.clear()
	dialogue_data = data

	_setup_signal_conn(0, dialogue_data.dialogue_id, dialogue_data.dialogue_root)
	# Setup signal connections. We need to navigate this like a tree.
	#var entry: DialogueEntryData = data.dialogue_root
	#var i: int = 0
	#while (entry):
		#if entry.next_entry:
			#_signal_emit_funcs.set(i, func(): 
				#dialogue_entry_reached.emit(data.dialogue_id,i))
		#else:
			#_signal_emit_funcs.set(i, func(): 
				#dialogue_entry_reached.emit(data.dialogue_id, i)
				#last_dialogue_entry_reached.emit(data.dialogue_id, i))
		#entry.dialogue_reached.connect(_signal_emit_funcs[i], CONNECT_ONE_SHOT)
		##_signal_discon_funcs.set(i, func(): entry.dialogue_reached.disconnect(_signal_emit_funcs[i]))
		#entry = entry.next_entry
		#i += 1

func _setup_signal_conn(idx: int, id: StringName, dialogue_entry: DialogueEntryData) -> DialogueEntryData:
	if not dialogue_entry: return null

	var next_entry := _setup_signal_conn(idx+1, id, dialogue_entry.next_entry)

	if next_entry:
		if next_entry is DialogueChoiceEntryData:
			_signal_emit_funcs.set(idx, func(choice_data: String):
				dialogue_entry_reached.emit(id, idx)
				# TODO: How do we want to deal with dialogue choices?
				# When they concern particular characters?
				dialogue_choice_made.emit(id, idx, choice_data))
		else:
			_signal_emit_funcs.set(idx, func():
				dialogue_entry_reached.emit(id, idx))
	else:
		_signal_emit_funcs.set(idx, func():
			dialogue_entry_reached.emit(id, idx)
			last_dialogue_entry_reached.emit(id, idx))
	dialogue_entry.dialogue_entry_reached.connect(_signal_emit_funcs[idx], CONNECT_ONE_SHOT)
	
	return dialogue_entry
	

func get_next_dialogue_entry() -> Dialogue:
	if not (active_entry): return Dialogue.new()
	
	if not active_entry:
		last_dialogue_entry_reached.emit()
	else:
		active_entry.entry_completed.emit()
		active_entry = active_entry.next_entry
		active_entry.entry_entered.emit()
	
	var dialogue := Dialogue.new()
	dialogue.speaker = active_entry.speaker.name
	dialogue.text = active_entry.entry_text

	return dialogue

func get_active_dialogue_entry() -> Dialogue:
	var dialogue := Dialogue.new()
	if dialogue_data and active_entry:
		dialogue.speaker = active_entry.speaker.name
		dialogue.text = active_entry.entry_text
	return dialogue

# FIXME: This was added so that the dialogue_control can force 
# the dialogue node to emit a signal with its actuve sequence.
# Probably want to delete this later.
func get_active_dialogue_entry_idx() -> int:
	return 0

# FIXME: This was added so that the dialogue_control can force 
# the dialogue node to emit a signal with its actuve sequence.
# Probably want to delete this later.
func get_active_sequence() -> int:
	return 0

# TODO: We no longer need to set a sequence.
func set_sequence(seq_idx: int) -> void:
	pass

func make_dialogue_choice(choice_idx: int) -> void:
	pass
	
