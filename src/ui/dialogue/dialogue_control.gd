extends Control

@onready var speaker_name_label: Label = $Panel/SpeakerNameLabel
@onready var rich_text_label: RichTextLabel = $CenterContainer/DialoguePanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var dialogue_choices: DialogueChoices = $CenterContainer/DialoguePanelContainer/MarginContainer/VBoxContainer/DialogueChoices

var dialogue_node: DialogueNode = null

var making_choice := false

func _input(event: InputEvent) -> void:
	var dialogue := Dialogue.new()
	if event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		if making_choice:
			making_choice = false
			var dc: DialogueChoice = dialogue_node.get_active_dialogue_entry()
			dialogue_node.set_sequence(dc.choices[dialogue_choices.get_focused_choice()].next_seq_idx)
			dialogue = dialogue_node.get_active_dialogue_entry()
		else:
			dialogue = dialogue_node.get_next_dialogue_entry()
		
		if not dialogue.text.is_empty():
			present_dialogue(dialogue)
		else:
			end_dialogue()
	elif event.is_action_pressed("ui_up") or event.is_action_pressed("ui_right") or event.is_action_pressed("walk_right"):
		if making_choice:
			dialogue_choices.focus_next()
	elif event.is_action_pressed("ui_down") or event.is_action_pressed("ui_left") or event.is_action_pressed("walk_left"):
		if making_choice:
			dialogue_choices.focus_prev()

func _ready() -> void:
	SignalEvents.ui_dialogue_present_requested.connect(_on_ui_dialogue_present_requested)
	visible = false
	set_process_input(false)

func _on_ui_dialogue_present_requested(dialogue_node_npath: NodePath) -> void:
	dialogue_node = get_node_or_null(dialogue_node_npath)
	if dialogue_node:
		visible = true
		get_tree().paused = true
		set_process_input(true)
		var dialogue := dialogue_node.get_active_dialogue_entry()
		present_dialogue(dialogue)

func end_dialogue() -> void:
	visible = false
	set_process_input(false)
	get_tree().paused = false
	dialogue_node = null
	SignalEvents.ui_dialogue_present_ended.emit()

func present_dialogue(dialogue: Dialogue) -> void:
	# TODO: Add option for choices		
	speaker_name_label.text = dialogue.speaker
	rich_text_label.text = dialogue.text
	if dialogue is DialogueChoice:
		dialogue_choices.set_choices(dialogue.choices)
		dialogue_choices.visible = true
		making_choice = true
	else:
		dialogue_choices.visible = false
		making_choice = false
