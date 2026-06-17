class_name DialogueChoices
extends HBoxContainer

const DIALOGUE_CHOICE_SCN = preload("uid://bl0mlhx8r712n")

var focused_choice_idx := 0

func set_focus(choice_idx: int) -> void:
	if not get_children().is_empty() and choice_idx < get_children().size():
		var label: RichTextLabel = get_child(choice_idx).get_node("Label")
		label.text = "[b]" + label.text + "[/b]";

func unfocus(choice_idx: int) -> void:
	if get_child_count() != 0 and choice_idx < get_child_count():
		var label: RichTextLabel = get_child(choice_idx).get_node("Label")
		label.text = label.text.trim_prefix("[b]").trim_suffix("[/b]")


func get_focused_choice() -> int:
	return focused_choice_idx

func focus_next() -> void:
	unfocus(focused_choice_idx)
	focused_choice_idx = wrapi(focused_choice_idx+1 ,0, get_child_count())
	set_focus(focused_choice_idx)

func focus_prev() -> void:
	unfocus(focused_choice_idx)
	focused_choice_idx = wrapi(focused_choice_idx-1, 0, get_child_count())
	set_focus(focused_choice_idx)

func set_choices(choices: Array[DialogueChoiceData]) -> void:
	if get_child_count() != 0:
		for c in get_children(): c.queue_free()

	var idx: int = 0
	for cd in choices:
		var choice: Node = DIALOGUE_CHOICE_SCN.instantiate()
		var label: RichTextLabel = choice.get_node("Label")
		label.text = cd.text
		add_child(choice)
		choice.owner = self
