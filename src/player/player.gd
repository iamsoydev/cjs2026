extends Node2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _unhandled_input(event: InputEvent) -> void:
	var dir := Input.get_vector("walk_left","walk_right","walk_up","walk_down")
	#TODO: Figure out how to adjust this. Need to look at a previous project
	ray_cast_2d.target_position = ray_cast_2d.to_global(dir)
	position += dir *3.4
