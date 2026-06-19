extends Node

# TODO: Respond to quests
# Quest Updated
# Quest Objected Updated
#  - Progressed it further?
#  - Now have access to a new part?
#  - Inform relevent quest listeners
@onready var pata: Actor = $Pata

var active_quest_idx: int = 0
var active_quest_obj_idx: int = 0

var quest := [
	{# 0
		'name': 'Wheat Eaters',
		'desc': "Find out who ate the farmer's wheat crop",
		'completed': false,
		'objectives': [
			{# 0
				'desc': 'Speak to the farmer about his issues',
				'completed': false
			},
			{# 1
				'desc': 'Talk to Kyle',
				'completed': false
			},
			{# 2
				'desc': 'Speak to Hans, Claudia, and Bertha to find out who ate the farmer\'s wheat',
				'completed': false
			},
			{# 3
				'desc': 'Report your findings to the farmer',
				'completed': false
			}
		]
	},
	{
		'name': 'The Accomplace',
		'desc': 'Find out who helped steal the wheat',
		'completed': false,
		'objectives': [
			{ # 0
				'desc': 'Speak to the farmer about the accomplace',
				'completed': false
			},
			{ # 1
				'desc': 'Speak to Earl, Earnie, Brenda and Barnie',
				'completed': false
			},
			{ # 2
				'desc': 'Report your findings to the farmer',
				'completed': false
			}
		]
	},
]

var answers: Array[String] = []

func verify_quest_completion(quest_idx: int) -> void:
	if quest_idx < quest.size():
		for o in quest[quest_idx].get('objectives'):
			if not o.get('completed'):
				return
		quest[quest_idx].set('completed', true)
		SignalEvents.quest_completed.emit(quest_idx)

func _on_quest_notify_objective_completed(quest_idx: int, quest_obj_idx: int) -> void:
	if quest_idx < quest.size():
		var o: Array = quest[quest_idx].get('objectives')
		if quest_obj_idx < o.size():
			if not o[quest_obj_idx].get('completed'):
				o[quest_obj_idx].set('completed', true)
				SignalEvents.quest_objective_completed.emit(quest_idx, quest_obj_idx)
				verify_quest_completion(quest_idx)

func _ready() -> void:
	SignalEvents.interaction_attempted.connect(_on_interaction_attempted)
	SignalEvents.quest_notify_objective_completed.connect(_on_quest_notify_objective_completed)
	SignalEvents.ui_dialogue_choice_made.connect(func(choice_text: String):
		answers.push_back(choice_text)
		match(choice_text.to_lower()):
			"bertha": pata.dialogue_node.set_sequence(3)
			"kyle": pata.dialogue_node.set_sequence(1)
			"claudia": pata.dialogue_node.set_sequence(4)
			"hans": pata.dialogue_node.set_sequence(2)
			_: pata.dialogue_node.set_sequence(0)
	)



func _on_interaction_attempted(
	type: InteractionNode.InteractionType,
	interacted_npath: NodePath,
	interacting_npath: NodePath
) -> void:
		var interacted_node: Node = get_node_or_null(interacted_npath)
		var interacting_node: Node = get_node_or_null(interacting_npath)

		var dialogue_node: DialogueNode
		var player_ray_cast_2d: RayCast2D
		if interacted_node:
			if interacted_node.has_node("DialogueNode"):
				dialogue_node = interacted_node.get_node("DialogueNode")
		if interacting_node:
			if interacting_node.has_node("RayCast2D"):
				player_ray_cast_2d = interacting_node.get_node("RayCast2D")

		player_ray_cast_2d.enabled = false
		SignalEvents.ui_dialogue_present_requested.emit(dialogue_node.get_path())
		await SignalEvents.ui_dialogue_present_ended
		await get_tree().create_timer(0.1).timeout
		player_ray_cast_2d.enabled = true
