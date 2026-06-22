class_name QuestObjectiveData
extends Resource

## A signal emitted from the QuestObjectiveData
signal quest_objective_started(objective_id: StringName)
signal quest_objective_completed(objective_id: StringName)
## A signal that is emitted from the QuestNode of an Actor.
## actor events go by [quest-obj string]_[actor]_[desc_name]
signal quest_actor_event_occured(event_name: StringName, msg: Dictionary)

@export var id := &""
@export_multiline var description: String = ""

var completed := false : set = set_completion

func start() -> void:
	quest_objective_started.emit(id)

func set_completion(is_completed: bool) -> void:
	if not completed and is_completed:
		completed = is_completed
		quest_objective_completed.emit(id)
