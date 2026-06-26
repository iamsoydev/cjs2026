extends Node

signal quest_objective_completed(quest_id: int, quest_objective_id: int)
signal quest_completed(quest_id: int)
## Used by Actors to notify game of an objective completion
signal quest_notify_objective_completed(quest_id: int, quest_objective_id: int)

signal interaction_started
signal interaction_finished

#TODO: This is ugly... but it works
signal player_disable_interaction_requested()
signal player_enable_interaction_requested()
