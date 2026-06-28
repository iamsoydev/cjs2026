extends Node

var aliases: Dictionary[StringName, CharacterData] = { }

func _ready() -> void:
	var dir = DirAccess.open("res://assets/data/characters/")
	for res_path in dir.get_files():
		var res := load("res://assets/data/characters/"+res_path)
		if res is CharacterData:
			res.generate_name()
			aliases[res.alias] = res
			

func alias_to_name(alias: StringName) -> String:
	if aliases.has(alias):
		return aliases[alias].name
	return ""
