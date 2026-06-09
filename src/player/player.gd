extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var movement_dir := Vector2.ZERO

func _ready() -> void:
	add_to_group("player")
	SignalEvents.player_enable_interaction_requested.connect( func(): ray_cast_2d.enabled = true)
	SignalEvents.player_disable_interaction_requested.connect( func(): ray_cast_2d.enabled = false)

func _physics_process(delta: float) -> void:
		velocity = movement_dir * 65
		move_and_slide()

func enabled_interaction() -> void:
	ray_cast_2d.enabled = true

func disable_interaction() -> void:
	ray_cast_2d.enabled = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if ray_cast_2d.is_colliding():
			var collider := ray_cast_2d.get_collider()
			if collider is InteractionNode:
				collider.init_interaction(get_path())
				
	movement_dir = Input.get_vector("walk_left","walk_right","walk_up","walk_down")
	#TODO: Figure out how to adjust this. Need to look at a previous project
	match(movement_dir):
		Vector2.DOWN:
			ray_cast_2d.rotation = deg_to_rad(0)
		Vector2.UP: 
			ray_cast_2d.rotation = deg_to_rad(180)
		Vector2.RIGHT:
			ray_cast_2d.rotation = deg_to_rad(-90)
		Vector2.LEFT:
			ray_cast_2d.rotation = deg_to_rad(90)
