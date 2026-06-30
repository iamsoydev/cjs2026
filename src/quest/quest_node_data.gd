class_name QuestNodeData
extends Resource

signal started(id: StringName)
signal became_startable(id: StringName)
signal completed(id: StringName)

enum StartDependancyTriggerType {
	TRIGGER_ON_STARTED,
	TRIGGER_ON_COMPLETED
}

@export var id: StringName = &""
@export_multiline var description: String = ""
@export var start_dependancies: Dictionary[QuestNodeData, StartDependancyTriggerType] = {}
@export var completion_dependancies: Array[QuestNodeData] = []
var start_dep_was_met: Dictionary[StringName, Callable] = {}
var complete: bool = false
var startable: bool = true ## Can this quest be started?
var has_started: bool = false

func check_dependancy_fulfillment(
	dep: QuestNodeData, 
	checked_prop: StringName,
	expected_value: bool
) -> bool:
	return (dep.get(checked_prop) as bool) == expected_value

func _init() -> void:
	if not start_dependancies.is_empty():
		for dep in start_dependancies.keys():
			var criteria_checker: Callable = func(): return false
			if start_dependancies[dep] == StartDependancyTriggerType.TRIGGER_ON_STARTED:				
				criteria_checker = func(): return dep.has_started
			elif start_dependancies[dep] == StartDependancyTriggerType.TRIGGER_ON_COMPLETED:
				criteria_checker = func(): return dep.complete
			start_dep_was_met.set(dep.id, criteria_checker)
			dep.started.connect(func(id: StringName):
				for dep_was_met in start_dep_was_met.values():
					if not dep_was_met.call(): return
				startable = true
				became_startable.emit(id))
		startable = false
	else:
		became_startable.emit(id)

	for dep in completion_dependancies:
		dep.quest_checkpoint_completed.connect(_on_completion_dependancy_met)
		
func _on_completion_dependancy_met(id: StringName) -> void:
	if complete: return
	for dep in completion_dependancies:
		if not dep.complete: return
	complete = true
	# FIXME: Defaults to just being true
	completed.emit(id, true)

## Function to manually set completion if the quest checkpoint does 
## not have any completion dependancies, otherwise this does nothing
func set_completed(was_passed: bool) -> void:
	if completion_dependancies.is_empty():
		complete = true
		completed.emit(id, was_passed)

func start() -> void:
	if startable:
		has_started = true
		started.emit(id)
