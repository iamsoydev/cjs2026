extends Actor

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func _on_quest_objective_completed(quest_id: int, quest_objective_id: int) -> void:
	if quest_id == 0 and quest_objective_id == 2:
		area_2d.body_entered.connect(_on_area_2d_body_entered)
		dialogue_node.set_sequence(2)

func _on_dialogue_node_last_dialogue_entry_reached(sequence_idx: int, entry_idx: int) -> void:
	if sequence_idx == 0:
		dialogue_node.set_sequence(1)
	elif sequence_idx == 1:
		dialogue_node.set_sequence(2)


func _on_area_2d_body_entered(body: Node2D) -> void:
	area_2d.body_entered.disconnect(_on_area_2d_body_entered)
	SignalEvents.ui_dialogue_present_requested.emit(dialogue_node.get_path())
