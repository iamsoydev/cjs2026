class_name Actor
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var dialogue_node: DialogueNode = $DialogueNode


@onready var interaction_node: InteractionNode = $InteractionNode
@onready var interaction_cooldown_timer: Timer = $InteractionCooldownTimer

func _on_interaction_cooldown_timer_timeout() -> void:
	pass # Replace with function body.

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	pass # Replace with function body.


func _on_dialogue_node_dialogue_choice_made(sequence_idx: int, entry_idx: int) -> void:
	pass # Replace with function body.
