class_name Actor
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var dialogue_node: DialogueNode = $DialogueNode
@onready var quest_node: QuestNode = $QuestNode

func _ready() -> void:
	SignalEvents.quest_objective_completed.connect(_on_quest_objective_completed)
	SignalEvents.quest_completed.connect(_on_quest_completed)
	

func _on_quest_objective_completed(quest_id: int, quest_objective_id: int) -> void:
	pass

func _on_quest_completed(quest_id: int) -> void:
	pass

func _on_interaction_cooldown_timer_timeout() -> void:
	pass # Replace with function body.

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	pass # Replace with function body.


func _on_dialogue_node_dialogue_choice_made(sequence_idx: int, entry_idx: int) -> void:
	pass # Replace with function body.


func _on_quest_node_quest_event_occured(occurance_time: int, objective_id: StringName) -> void:
	pass # Replace with function body.
