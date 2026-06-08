class_name InteractionNode
extends Area2D

@export_node_path("Timer") var cooldown_timer_npath := NodePath()
@onready var cooldown_timer: Timer = get_node(cooldown_timer_npath)

func _ready() -> void:
	cooldown_timer.timeout.connect( func(): monitorable = true )
	# How do we know when the interaction is complete?

func init_interaction(interacting_npath: NodePath) -> void:
	SignalEvents.interaction_attempted.emit(owner.get_path(), interacting_npath, get_path())

func start_interaction() -> void:
	monitorable = false

func end_interaction() -> void:
	cooldown_timer.start()
