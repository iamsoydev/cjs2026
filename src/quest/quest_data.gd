class_name QuestData
extends Resource

@export var id := &""
@export var name: String = ""
@export_multiline var description: String = ""
@export var objectives: Array[QuestObjectiveData] = []

var completed := false
