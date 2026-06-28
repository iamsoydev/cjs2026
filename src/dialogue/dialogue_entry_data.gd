class_name DialogueEntryData
extends Resource

signal dialogue_entry_reached

@export var speaker_alias: StringName = &""
@export_multiline var entry_text: String
@export var next_entry: DialogueEntryData

# TODO: Define events that occur.
