@tool
extends Actor

const CHICKEN_BLUE_SPRITE = preload("uid://bjk8baebiurdd")
const CHICKEN_BROWN_SPRITE = preload("uid://dq0y84hpoip5l")
const CHICKEN_DEFAULT_SPRITE = preload("uid://cvr8x5rab5xtw")
const CHICKEN_GREEN_SPRITE = preload("uid://djulb14rkvp32")
const CHICKEN_RED_SPRITE = preload("uid://o8ufurw6od3p")

@export_enum("Light", "Brown", "Green", "Red", "Blue") var type: int = 0 : set = set_type

func set_type(t: int) -> void:
	type = t
	if Engine.is_editor_hint():
		if sprite_2d and sprite_2d.is_node_ready():
			var texture: Texture2D
			match(type):
				0: texture = CHICKEN_DEFAULT_SPRITE
				1: texture = CHICKEN_BROWN_SPRITE
				2: texture = CHICKEN_GREEN_SPRITE
				3: texture = CHICKEN_RED_SPRITE
				4: texture = CHICKEN_BLUE_SPRITE
				_: texture = CHICKEN_DEFAULT_SPRITE
			sprite_2d.texture = texture
