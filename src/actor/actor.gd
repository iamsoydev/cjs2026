class_name Actor
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var dialogue_node: DialogueNode = $DialogueNode
@onready var quest_node: QuestNode = $QuestNode

@export var character_data: CharacterData

func _ready() -> void:
	if character_data: character_data.generate_name()

func _on_dialogue_node_dialogue_entry_reached(dialogue_id: StringName, entry_idx: int) -> void:
	pass # Replace with function body.

func _on_dialogue_node_dialogue_last_entry_reached(dialogue_id: StringName, entry_idx: int) -> void:
	pass # Replace with function body.
