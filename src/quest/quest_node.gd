class_name QuestNode
extends Node

enum QuestEventType {
	COMPLETED,
	STARTED
}

signal quest_event_occured(origin_id: StringName, event_type: QuestEventType)

## The Quest, Quest Objective and Quest Objective tasks we will be listening for events from.
## This includes Quest Data, Quest Objective Data and
## Quest Objective Task Data
@export var quest_checkpoints: Array[Resource] = []
var checkpoints: Dictionary[StringName, Resource] = {}

func _ready() -> void:
	## TODO: Distinguish the quest event type
	for res in quest_checkpoints:
		if res is QuestData:
			res.quest_completed.connect(func(id: StringName):
				quest_event_occured.emit(id, QuestEventType.COMPLETED))
			res.quest_started.connect(func(id: StringName):
				quest_event_occured.emit(id, QuestEventType.STARTED))
		elif res is QuestObjectiveData:
			res.quest_objective_completed.connect(func(id: StringName):
				quest_event_occured.emit(id, QuestEventType.COMPLETED))
			res.quest_objective_started.connect(func(id: StringName):
				quest_event_occured.emit(id, QuestEventType.STARTED))
		elif res is QuestObjectiveTaskData:
			res.quest_objective_task_completed.connect(func(id: StringName):
				quest_event_occured.emit(id, QuestEventType.COMPLETED))

func update_quest_checkpoint_status(was_passed: bool, id: StringName) -> void:
	pass
