extends Control

@onready var speaker_name_label: Label = $Panel/SpeakerNameLabel
@onready var rich_text_label: RichTextLabel = $CenterContainer/DialoguePanelContainer/MarginContainer/RichTextLabel

var dialogue_node: DialogueNode = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		# TODO: Are we making a choice or progressing the dialogue?
		# Get Next segment requested
		var dialogue: Dialogue = dialogue_node.get_next_dialogue_entry()
		if not dialogue.text.is_empty():
			present_dialogue(dialogue)
		else:
			end_dialogue()
	elif event.is_action_pressed("ui_up"):
		pass
	elif event.is_action_pressed("ui_down"):
		pass

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
