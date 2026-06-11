@tool
extends Actor

const BROWN_COW_SPRITES = preload("uid://uj0vqttupncw")
const GREEN_COW_SPRITES = preload("uid://bxamo0h5005ut")
const LIGHT_COW_SPRITES = preload("uid://csl6ww1pnykb3")
const PINK_COW_SPRITES  = preload("uid://b0bkrk1nes5nn")
const PURPLE_COW_SPRITES= preload("uid://cbkdjft6vyjc8")


@export_enum("Light", "Brown", "Green", "Pink", "Purple") var type: int = 0 : set = set_type

func set_type(t: int) -> void:
	type = t
	if Engine.is_editor_hint():
		if sprite_2d and sprite_2d.is_node_ready():
			var texture: Texture2D
			match(type):
				0: texture = LIGHT_COW_SPRITES
				1: texture = BROWN_COW_SPRITES
				2: texture = GREEN_COW_SPRITES
				3: texture = PINK_COW_SPRITES
				4: texture = PURPLE_COW_SPRITES
				_: texture = LIGHT_COW_SPRITES
			sprite_2d.texture = texture
