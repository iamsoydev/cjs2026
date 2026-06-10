extends Control

@onready var speaker_name_label: Label = $Panel/SpeakerNameLabel
@onready var rich_text_label: RichTextLabel = $CenterContainer/DialoguePanelContainer/MarginContainer/RichTextLabel

var dialogue_node: DialogueNode = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		# Next segment requested
		current_dialogue_data = current_dialogue_data.next_dialogue
		if current_dialogue_data:
			present_dialogue(current_dialogue_data.speaker, current_dialogue_data.text)
		else:
			end_dialogue()

func _ready() -> void:
	SignalEvents.ui_dialogue_present_requested.connect(_on_ui_dialogue_present_requested)
	visible = false
	set_process_input(false)

func _on_ui_dialogue_present_requested(dialogue_node_npath: NodePath) -> void:
	# TODO: This should be handled in game.gd?
	visible = true
	get_tree().paused = true
	set_process_input(true)

	var dia_node: DialogueNode = get_node_or_null(dialogue_node_npath)
	if dia_node:
		dialogue_node = dia_node
	else:
		end_dialogue()

	var d_data := dialogue_node.get_current_dialogue_set()
	present_dialogue(d_data.speaker, d_data.text)

func end_dialogue() -> void:
	visible = false
	set_process_input(false)
	get_tree().paused = false
	dialogue_node = null
	SignalEvents.ui_dialogue_present_ended.emit()

func present_dialogue(speaker: String, text: String) -> void:
	speaker_name_label.text = speaker
	rich_text_label.text = text
