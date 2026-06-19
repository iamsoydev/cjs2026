@tool
extends Actor

const BABY_LIGHT_COW_ANIMATIONS_SPRITES = preload("uid://cmksjltcbyllj")
const BABY_BROWN_COW_ANIMATIONS_SPRITES = preload("uid://cg578kl6u0lbt")
const BABY_GREEN_COW_ANIMATIONS_SPRITES = preload("uid://ctt5i8xnsxhl1")
const BABY_PINK_COW_ANIMATIONS_SPRITES = preload("uid://bvdkd0fq3kwxy")
const BABY_PURPLE_COW_ANIMATIONS_SPRITES = preload("uid://c0ewmokv0s54x")

@export_enum("Light", "Brown", "Green", "Pink", "Purple") var type: int = 0 : set = set_type

func set_type(t: int) -> void:
	type = t
	if Engine.is_editor_hint():
		if sprite_2d and sprite_2d.is_node_ready():
			var texture: Texture2D
			match(type):
				0: texture = BABY_LIGHT_COW_ANIMATIONS_SPRITES
				1: texture = BABY_BROWN_COW_ANIMATIONS_SPRITES
				2: texture = BABY_GREEN_COW_ANIMATIONS_SPRITES
				3: texture = BABY_PINK_COW_ANIMATIONS_SPRITES
				4: texture = BABY_PURPLE_COW_ANIMATIONS_SPRITES
				_: texture = BABY_LIGHT_COW_ANIMATIONS_SPRITES
			sprite_2d.texture = texture
