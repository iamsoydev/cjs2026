class_name UIDialogueControl
extends Control

signal next_dialogue_requested
signal dialogue_choice_made
signal dialogue_present_finished
signal dialogue_present_started

@onready var speaker_name_label: Label = $Panel/SpeakerNameLabel
@onready var rich_text_label: RichTextLabel = $CenterContainer/DialoguePanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var dialogue_choices: DialogueChoices = $CenterContainer/DialoguePanelContainer/MarginContainer/VBoxContainer/DialogueChoices

var making_choice := false
var _presenting := false
var template_regex := RegEx.new()

func _ready() -> void:
	# TODO: Should UIDialogueControl read in character data independantly
	#	instead of getting it from CharacterDB?
	template_regex.compile("{{.*?}}")
	dialogue_present_started.connect(func(): _presenting = true)
	dialogue_present_finished.connect(func(): _presenting = false)

func _input(event: InputEvent) -> void:
	# TODO: Add Choice Functionality
	if event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		if _presenting:
			_presenting = false
		else:
			next_dialogue_requested.emit()
	elif event.is_action_pressed("ui_up") or event.is_action_pressed("ui_right") or event.is_action_pressed("walk_right"):
		if making_choice:
			dialogue_choices.focus_next()
	elif event.is_action_pressed("ui_down") or event.is_action_pressed("ui_left") or event.is_action_pressed("walk_left"):
		if making_choice:
			dialogue_choices.focus_prev()

func process_dialogue_text(entry_text: String) -> String:
	var ret := entry_text
	var k := template_regex.search(entry_text)
	while k:
		var alias = k.strings[0].trim_prefix("{{").trim_suffix("}}")
		var character_name := CharacterDB.alias_to_name(alias)
		if character_name.is_empty(): character_name = "Not Found"
		ret = ret.replace(k.strings[0], character_name)
		k = template_regex.search(entry_text, k.get_end())
	return ret

func present_dialogue(dialogue: DialogueEntryData) -> void:
	speaker_name_label.text = CharacterDB.alias_to_name(dialogue.speaker_alias)
	var text := process_dialogue_text(dialogue.entry_text)
	rich_text_label.visible_characters = 0
	rich_text_label.text = text
	dialogue_present_started.emit()
	while rich_text_label.visible_characters != text.length():
		if not _presenting: rich_text_label.visible_characters = -1; break
		rich_text_label.visible_characters += 1
		await get_tree().create_timer(0.03).timeout
	dialogue_present_finished.emit()
