extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@export var spawned_characters: Array[CharacterData] = []

func spawn_characters() -> void:
	pass

func _ready() -> void:
	area_2d.get_coll
