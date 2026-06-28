extends Resource

@export var characters: Array[CharacterData] = []

var aliases: Dictionary[StringName, CharacterData]

func _init() -> void:
	for c in characters: aliases[c.alias] = c
	aliases.make_read_only()
	characters.make_read_only()
