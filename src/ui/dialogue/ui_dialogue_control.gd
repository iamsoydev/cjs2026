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

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	var dialogue := Dialogue.new()
	if event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		if making_choice:
			making_choice = false
			# TODO: Record made choice
			# FIXME: I shouldn't be doing this to trigger the completion of a quest
			#dialogue_node.last_dialogue_entry_reached.emit(dialogue_node.get_active_sequence(), dialogue_node.get_active_dialogue_entry_idx())
			#dialogue_node.set_sequence(dc.choices[dialogue_choices.get_focused_choice()].next_seq_idx)
			#SignalEvents.ui_dialogue_choice_made.emit(dc.choices[dialogue_choices.get_focused_choice()].text)
			#dialogue = dialogue_node.get_active_dialogue_entry()
		else:
			next_dialogue_requested.emit()
	elif event.is_action_pressed("ui_up") or event.is_action_pressed("ui_right") or event.is_action_pressed("walk_right"):
		if making_choice:
			dialogue_choices.focus_next()
	elif event.is_action_pressed("ui_down") or event.is_action_pressed("ui_left") or event.is_action_pressed("walk_left"):
		if making_choice:
			dialogue_choices.focus_prev()

func present_dialogue(dialogue: DialogueEntryData) -> void:
	speaker_name_label.text = dialogue.speaker.name

	# TODO: perform presentation anims
	dialogue_present_started.emit()
	rich_text_label.text = dialogue.entry_text
	dialogue_present_finished.emit()
	#if dialogue is DialogueChoice:
		#dialogue_choices.set_choices(dialogue.choices)
		#dialogue_choices.visible = true
		#making_choice = true
	#else:
		#dialogue_choices.visible = false
		#making_choice = false
