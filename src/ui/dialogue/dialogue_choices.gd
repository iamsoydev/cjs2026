class_name DialogueChoices
extends HBoxContainer

const DIALOGUE_CHOICE_SCN = preload("uid://bl0mlhx8r712n")

func set_focus(choice_idx: int) -> void:
	if not get_children().is_empty() and choice_idx < get_children().size():
		var label: Label = get_child(choice_idx).get_node("Label")
		# TODO: Highlight label for selection

func set_choices(choices: Array[DialogueChoiceData]) -> void:
	var idx: int = 0
	for cd in choices:
		var choice: Node = DIALOGUE_CHOICE_SCN.instantiate()
		var label: Label = choice.get_node("Label")
		label.text = cd.text
		add_child(choice)
		choice.owner = self
