class_name QuestNode
extends Node

# TODO: How do I model this? There are events that take place during
#		a quest that are not related to the beginning or end
#		of a quest. How are these emitted? Can we reference Quest
#		objectives through the quest node to emit signals?

signal quest_event_occured(event_type: Quest.Event, objective_id: StringName)

@export var quests: Array[QuestObjectiveData]

func _ready() -> void:
	for quest in quests:
		quest.quest_objective_started.connect(func(objective_id: StringName):
			quest_event_occured.emit(Quest.Event.ON_START, objective_id))
		quest.quest_objective_completed.connect(func(objective_id: StringName):
			quest_event_occured.emit(Quest.Event.ON_COMPLETE, objective_id))

func notify_quest_event(event) -> void:
	# TODO: Get the related quest objective and emit a signal containing
	#		data related to the event under that objective
	pass
