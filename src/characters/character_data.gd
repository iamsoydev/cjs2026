class_name CharacterData
extends Resource

signal colour_changed(new_colour: Color)

var name: String = ""
var colour: Color = Color.WHITE

@export var name_pool: Array[String] = []
@export var colour_pool: ColorPalette = ColorPalette.new()
@export var quest_answer: Dictionary[QuestData, bool] = {}
@export var spawn_pool: Array[Vector2] = []
@export var dialogue: DialogueData = DialogueData.new()

func generate_name() -> void:
	if not (name.is_empty() and name_pool.is_empty()):
		name = name_pool.pick_random()

func generate_colour() -> void:
	if not colour_pool.is_empty():
		colour = colour_pool.colors.get(randi_range(0, colour_pool.colors.size()-1))

func generate_spawn_location() -> void:
	# TODO: ensure the generated spawn location is not taken
	pass
