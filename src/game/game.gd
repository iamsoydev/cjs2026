extends Node

@onready var dialogue_control: Control = $UI/RootControl/DialogueControl
@onready var speaker_name_label: Label = $UI/RootControl/DialogueControl/Panel/SpeakerNameLabel
@onready var rich_text_label: RichTextLabel = $UI/RootControl/DialogueControl/CenterContainer/DialoguePanelContainer/MarginContainer/RichTextLabel
@onready var sub_viewport: SubViewport = $ViewportCanvasLayer/SubViewportContainer/SubViewport

#TODO: Moves this out into its own system
var loaded_dialogue_data: DialogueData
var current_dialogue_data: DialogueData

var player: CharacterBody2D = null

func _ready() -> void:
	SignalEvents.ui_dialogue_visibility_change_requested.connect(
		_on_ui_dialogue_visibility_change_requested)
	SignalEvents.ui_dialogue_present_requested.connect(
		_on_ui_dialogue_present_requested)
	SignalEvents.interaction_attempted.connect(
		_on_interaction_attempted
	)
	SignalEvents.ui_dialogue_next_segment_requested.connect(
		_on_ui_dialogue_next_segment_requested
	)

	# Retrieve Player node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and dialogue_control.visible:
		SignalEvents.ui_dialogue_next_segment_requested.emit()
		print("Segment requested")

func _on_interaction_attempted(
	interacted_npath: NodePath,
	interacting_npath: NodePath,
	source_npath: NodePath
) -> void:
	print("interaction attempted")
	var interacting_node: Node = get_node_or_null(interacting_npath)
	var interacted_node: Node = get_node_or_null(interacted_npath)
	var interaction_node: InteractionNode = get_node_or_null(source_npath)

	if interacted_node and interacted_node.has_node("DialogueNode"):
		if interaction_node:
			interaction_node.start_interaction()
			SignalEvents.interaction_ended.connect( func(): interaction_node.end_interaction() )
		var d: DialogueNode = interacted_node.get_node("DialogueNode")
		loaded_dialogue_data = d.dialogue_data
		current_dialogue_data = d.dialogue_data
		present_dialogue(current_dialogue_data)

func _on_ui_dialogue_visibility_change_requested(is_visible: bool) -> void:
	show_dialogue_ui() if is_visible else hide_dialogue_ui()

func _on_ui_dialogue_present_requested(dialogue_data: DialogueData) -> void:
	present_dialogue(dialogue_data)

func _on_ui_dialogue_next_segment_requested() -> void:
	current_dialogue_data = current_dialogue_data.next_dialogue
	if not current_dialogue_data:
		hide_dialogue_ui()
		SignalEvents.interaction_ended.emit()
	else:
		present_dialogue(current_dialogue_data)

func show_dialogue_ui() -> void:
	SignalEvents.player_disable_interaction_requested.emit()
	dialogue_control.visible = true
	get_tree().paused = true

func hide_dialogue_ui() -> void:
	print("Hiding Dialogue")
	dialogue_control.visible = false
	print("interaction ended")
	dialogue_control.visible = false
	get_tree().paused = false
	SignalEvents.player_enable_interaction_requested.emit()

func present_dialogue(dialogue_data: DialogueData) -> void:
	speaker_name_label.text = dialogue_data.speaker
	rich_text_label.text = dialogue_data.text
	show_dialogue_ui()
	
