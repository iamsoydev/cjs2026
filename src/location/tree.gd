@tool
extends Node2D

const TREE_SPRITES = preload("uid://6vg10sx8cv6w")
const TREE_APPLE_SPRITES = preload("uid://cuf5s1pn3xkxi")
const TREE_ORANGE_SPRITES = preload("uid://b68avaa6a8dpf")
const TREE_PEACH_SPRITES = preload("uid://b676pcmacjd35")
const TREE_PEAR_SPRITES = preload("uid://bfeimlcdxl1d4")


@onready var sprite_2d: Sprite2D = $Sprite2D

@export_enum("Default", "Apple", "Orange", "Peach", "Pear") var type: int = 0 : set = set_type

func set_type(t: int) -> void:
	type = t
	if Engine.is_editor_hint():
		if sprite_2d and sprite_2d.is_node_ready():
			var texture: Texture2D
			match(type):
				0: texture = TREE_SPRITES
				1: texture = TREE_APPLE_SPRITES
				2: texture = TREE_ORANGE_SPRITES
				3: texture = TREE_PEACH_SPRITES
				4: texture = TREE_PEAR_SPRITES
				_: texture = TREE_SPRITES
			sprite_2d.texture = texture
