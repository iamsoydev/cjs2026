class_name ScoreSummary # FIXME: Doesn't need to be a class?
extends Control

@onready var quest_a_pass_fail_label: Label = $CenterContainer/Panel/VBoxContainer/HBoxContainer/PassFailLabel
@onready var quest_b_pass_fail_label: Label = $CenterContainer/Panel/VBoxContainer/HBoxContainer2/PassFailLabel

func set_quest_result(quest_id: int, was_passed: bool) -> void:
	if quest_id == 0:
		quest_a_pass_fail_label.text = "Pass" if was_passed else "Failed"
	if quest_id == 1:
		quest_b_pass_fail_label.text = "Pass" if was_passed else "Failed"
