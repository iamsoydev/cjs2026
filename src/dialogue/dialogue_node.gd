# TODO: Should I DialogueNode be an instance of a conversation that 
# is shared by multiple characters in a single point in time?
# Perhaps the node itself is something that can initiate the dialogue
# but the dialogue system pulls in all charactes so they can be
# notified via signals.

## An interface between the dialogue data and the scriptable actor
class_name DialogueNode
extends Node

signal dialogue_last_entry_reached(dialogue_id: StringName, entry_idx: int)
signal dialogue_entry_reached(dialogue_id: StringName, entry_idx: int)
signal dialogue_choice_made(dialogue_id: StringName, entry_idx: int, choice_data: String)

@export var dialogue_data: DialogueData = null #: set = set_dialogue_data

var _signal_emit_funcs: Array[Callable] = []
#var _signal_discon_funcs: Array[Callable] = []

func setup_signals() -> void:
	_setup_signal_conn(0, dialogue_data.dialogue_id, dialogue_data.dialogue_root)

#func _ready() -> void:
#	_setup_signal_conn(0, dialogue_data.dialogue_id, dialogue_data.dialogue_root)

#func set_dialogue_data(data: DialogueData) -> void:
	#if not _signal_emit_funcs.is_empty(): 
		##_signal_discon_funcs.all(call)
		#_signal_emit_funcs.clear()
	#dialogue_data = data
#
	#_setup_signal_conn(0, dialogue_data.dialogue_id, dialogue_data.dialogue_root)

func _setup_signal_conn(idx: int, id: StringName, dialogue_entry: DialogueEntryData) -> void:
	if not dialogue_entry: return
	
	_signal_emit_funcs.resize(_signal_emit_funcs.size()+1)
	if dialogue_entry.next_entry:
		_setup_signal_conn(idx+1, id, dialogue_entry.next_entry)
		if dialogue_entry is DialogueChoiceEntryData:
			_signal_emit_funcs.set(idx,  func(choice_data: String):
				dialogue_entry_reached.emit(id, idx)
				# TODO: How do we want to deal with dialogue choices?
				# When they concern particular characters?1
				dialogue_choice_made.emit(id, idx, choice_data))
		else:
			_signal_emit_funcs.set(idx, func():
				dialogue_entry_reached.emit(id, idx))
	else:
		_signal_emit_funcs.set(idx, func():
			dialogue_entry_reached.emit(id, idx)
			dialogue_last_entry_reached.emit(id, idx))

	dialogue_entry.dialogue_entry_reached.connect(_signal_emit_funcs[idx], CONNECT_ONE_SHOT)
