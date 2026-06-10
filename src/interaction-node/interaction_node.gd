class_name InteractionNode
extends Area2D

@export_node_path("Timer") var cooldown_timer_npath := NodePath()
@onready var cooldown_timer: Timer = get_node(cooldown_timer_npath)

@export var interaction_target_npath: NodePath = NodePath()

func _ready() -> void:
	cooldown_timer.timeout.connect( func(): monitorable = true )
	# How do we know when the interaction is complete?

func init_interaction(interacting_npath: NodePath) -> void:
	var iprops := InteractionProperties.new() 
	iprops.interaction_node_npath = get_path()
	iprops.interaction_target_npath = get_node(interaction_target_npath).get_path()
	SignalEvents.interaction_attempted.emit(iprops)

func start_interaction() -> void:
	monitorable = false

func end_interaction() -> void:
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		print("Interaction Cooldown initiated")
