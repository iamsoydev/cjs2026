class_name Actor
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var dialogue_node: DialogueNode = $DialogueNode


@onready var interaction_node: InteractionNode = $InteractionNode
@onready var interaction_cooldown_timer: Timer = $InteractionCooldownTimer

func _on_interaction_cooldown_timer_timeout() -> void:
	pass # Replace with function body.
