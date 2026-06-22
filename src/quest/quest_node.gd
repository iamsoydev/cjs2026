class_name QuestNode
extends Node

signal quest_event_occured(
	event_type: Quest.Event,
	origin_id: StringName,
	msg: Dictionary)

# TODO: Come up with a better name for this
## The Quest Objectives we will be listening for events
@export var quest_objectives: Array[QuestObjectiveData]
var objectives: Dictionary[StringName, QuestObjectiveData] = {}

func _ready() -> void:
	for obj in quest_objectives:
		objectives.set(obj.id, obj)
		obj.quest_objective_started.connect(
			func(origin_id: StringName):
				quest_event_occured.emit(
					Quest.Event.ON_START, origin_id, {}))
		obj.quest_objective_completed.connect(
				func(origin_id: StringName):
					quest_event_occured.emit(
						Quest.Event.ON_COMPLETE, origin_id, {}))
		obj.quest_actor_event_occured.connect(
			func(origin_id: StringName, msg: Dictionary):
				quest_event_occured.emit(
					Quest.Event.ON_ACTOR_EVENT, origin_id, msg))

func notify_actor_event_occured(objective_id: StringName, event_name: StringName) -> void:
	if objectives.has(objective_id):
		objectives.get(objective_id).quest_actor_event_occured.emit(event_name)

func notify_objective_completed(objective_id: StringName) -> void:
	if objectives.has(objective_id):
		objectives.get(objective_id).set_completion(true)
