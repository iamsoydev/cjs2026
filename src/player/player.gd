extends Node2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _unhandled_input(event: InputEvent) -> void:
	var dir := Input.get_vector("walk_left","walk_right","walk_up","walk_down")
	#TODO: Figure out how to adjust this. Need to look at a previous project
	position += dir *3.4
	match(dir):
		Vector2.DOWN:
			ray_cast_2d.rotation = deg_to_rad(0)
		Vector2.UP: 
			ray_cast_2d.rotation = deg_to_rad(180)
		Vector2.RIGHT:
			ray_cast_2d.rotation = deg_to_rad(-90)
		Vector2.LEFT:
			ray_cast_2d.rotation = deg_to_rad(90)
