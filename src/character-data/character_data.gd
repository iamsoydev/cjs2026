class_name CharacterData
extends Resource

var name: String = ""
var colour: Color = Color.WHITE

# TODO: Use Substitution to replace

## Used for substitution/templating
@export var alias := &""
@export var name_pool: Array[String] = []
@export var dialogues: Array[DialogueData] = []

func generate_name() -> void:
	var attempts: int = 0
	var visited: PackedInt32Array = []
	if not (name.is_empty() and name_pool.is_empty()):
		name = name_pool.pick_random()

func generate_spawn_location() -> void:
	# TODO: ensure the generated spawn location is not taken
	pass
