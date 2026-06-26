extends Node

# TODO: Respond to quests
# Quest Updated
# Quest Objected Updated
#  - Progressed it further?
#  - Now have access to a new part?
#  - Inform relevent quest listeners
@onready var location: Node2D = $ViewportCanvasLayer/SubViewportContainer/SubViewport/World/Location
@onready var score_summary: ScoreSummary = $UI/ScoreSummary
@onready var ui_root_control: Control = $UI/UIRootControl
@onready var ui_dialogue_control: UIDialogueControl = $UI/UIRootControl/UIDialogueControl
# TODO: Create quest object
# Quest event object
# Quest objective
# Quest 

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

var active_quest_idx := 0
var answers: Array[String] = []

func verify_quest_completion(quest_idx: int) -> void:
	if quest_idx < quest.size():
		for o in quest[quest_idx].get('objectives'):
			if not o.get('completed'):
				return
		quest[quest_idx].set('completed', true)
		SignalEvents.quest_completed.emit(quest_idx)
		
		active_quest_idx += 1 if quest.size() > quest_idx+1 else 0

func _on_quest_notify_objective_completed(quest_idx: int, quest_obj_idx: int) -> void:
	if quest_idx < quest.size():
		var o: Array = quest[quest_idx].get('objectives')
		if quest_obj_idx < o.size():
			if not o[quest_obj_idx].get('completed'):
				o[quest_obj_idx].set('completed', true)
				SignalEvents.quest_objective_completed.emit(quest_idx, quest_obj_idx)
				verify_quest_completion(quest_idx)

func start_ui() -> void:
	get_tree().paused = true
	ui_root_control.set_process_input(true)

func end_ui() -> void:
	get_tree().paused = false
	ui_root_control.set_process_input(false)

func start_dialogue(dialogue_root: DialogueEntryData) -> void:
	var dialogue := dialogue_root
	ui_dialogue_control.visible = true
	while(dialogue):
		dialogue.dialogue_entry_reached.emit()
		ui_dialogue_control.present_dialogue(dialogue)
		await ui_dialogue_control.next_dialogue_requested
		dialogue = dialogue.next_entry
	ui_dialogue_control.visible = false
	# TODO: Emit when dialogue ends?

func _on_interaction_occured(interaction_target_npath: NodePath):
	var target := get_node_or_null(interaction_target_npath)
	if target and target is DialogueNode:
		SignalEvents.interaction_started.emit()
		start_ui()
		await start_dialogue(target.dialogue_data.dialogue_root)
		end_ui()
		SignalEvents.interaction_finished.emit()


func _ready() -> void:
	for inode in get_tree().get_nodes_in_group("interaction_nodes"):
		if inode is InteractionNode:
			inode.interaction_occured.connect(_on_interaction_occured)
	

	## FIXME: Definitely should change the dialogue system to account for this
	#SignalEvents.ui_dialogue_choice_made.connect(func(choice_text: String):
		#answers.push_back(choice_text))
#
	#if answers.size() == 1:
		#pass
		##match(choice_text.to_lower()):
			##"bertha": pata.dialogue_node.set_sequence(3)
			##"kyle": pata.dialogue_node.set_sequence(1)
			##"claudia": pata.dialogue_node.set_sequence(4)
			##"hans": pata.dialogue_node.set_sequence(2)
			##_: pata.dialogue_node.set_sequence(0)
	#elif answers.size() == 2:
		#if answers[0].to_lower() == 'claudia':
			#score_summary.set_quest_result(0, true)
		#else:
			#score_summary.set_quest_result(0, false)
		#if answers[1].to_lower() == 'earl':
			#score_summary.set_quest_result(1, true)
		#else:
			#score_summary.set_quest_result(1, false)
		#score_summary.visible = true
		# TODO: Introduce Endgame
