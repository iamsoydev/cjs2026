@abstract class_name Actor
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var interaction_node: InteractionNode = $InteractionNode
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogue_node: DialogueNode = $DialogueNode

@export var character_data: CharacterData

func _ready() -> void:
	if character_data:
		dialogue_node.dialogue_data = character_data.dialogues[0]

@abstract func _on_dialogue_node_dialogue_entry_reached(dialogue_id: StringName, entry_idx: int)

@abstract func _on_dialogue_node_dialogue_last_entry_reached(dialogue_id: StringName, entry_idx: int)
