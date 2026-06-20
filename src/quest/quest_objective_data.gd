class_name QuestObjectiveData
extends Resource

# TODO: Provide the ability to define quest events through
#		exported variables

signal quest_objective_started(objective_id: StringName)
signal quest_objective_completed(objective_id: StringName)

@export var id := &""
@export_multiline var description: String = ""
var completed := false : set = set_completion

func start() -> void:
	quest_objective_started.emit(id)

func set_completion(is_completed: bool) -> void:
	if not completed and is_completed:
		completed = is_completed
		quest_objective_completed.emit(id)
