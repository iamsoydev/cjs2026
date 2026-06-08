class_name Actor
extends CharacterBody2D

@onready var interaction_node: InteractionNode = $InteractionNode
@onready var interaction_cooldown_timer: Timer = $InteractionCooldownTimer


func _on_interaction_cooldown_timer_timeout() -> void:
	pass # Replace with function body.
