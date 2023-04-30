extends Node2D

signal on_complete

var convo
var convo_idx = 0
var convo_step_in_progress = false
var responses_to_wrong_input
var responses_to_correct_input

var is_seasalt_talking = false

onready var speech_bubble = $SpeechBubble
onready var speech_timer = $Timer
onready var engine = $LevelEngine
onready var sea_salt = $SeaSalt

func _ready():
	convo = get_convo()


func _physics_process(delta):
	if not convo_step_in_progress and convo_idx < len(convo):
		var step = convo[convo_idx]
		convo_step_in_progress = true
		var subject = step['subject']
		var action = step['action']
		if subject == 'wingman' and action == 'say':
			handle_wingman_say(step)
			yield(speech_timer, "timeout")
		elif subject == 'player' and action == 'input':
			responses_to_correct_input = step['ok']
			responses_to_wrong_input = step['err']
			engine.show()
			print('waiting on_complete')
			yield(engine, "on_complete")
			print('done waiting on_complete')
		convo_idx += 1
		convo_step_in_progress = false
		
func handle_wingman_say(step):
	print('handle_wingman_say ', step, ' ', speech_timer.time_left, ' ', speech_timer.is_stopped())
	var message = step['message']
	is_seasalt_talking = true
	sea_salt.talk(step)
	speech_bubble.text = message
	speech_timer.wait_time = Globals.convo_wait_duration + 3
	speech_timer.start()


func _on_LevelEngine_on_complete():
	if responses_to_correct_input != null:
		engine.hide()
		for step in responses_to_correct_input:
			var subject = step['subject']
			var action = step['action']
			if subject == 'wingman' and action == 'say':
				handle_wingman_say(step)
				yield(speech_timer, "timeout")
			elif subject == 'game' and action == 'emit_signal':
				emit_signal("on_complete")
	

func _on_SeaSalt_on_finish_talking():
	is_seasalt_talking = false
	
func _on_LevelEngine_on_wrong():
	print('emma level got on wrong ', responses_to_wrong_input, ' is_seasalt_talking ', is_seasalt_talking)
	if responses_to_wrong_input != null and not is_seasalt_talking:
		var step = responses_to_wrong_input[0]
		handle_wingman_say(step)


func get_convo():
	return [
		{
			"subject": "wingman",
			"action": "say",
			"message": "Now, me heartie, it be time to show yer attentiveness. Say her name as ye speak to her, arr!",
			"audio": "emma_01"
		},
		{
			"subject": "player",
			"action": "input",
			"ok": [
				{
					"subject": "wingman",
					"action": "say",
					"message": "Arr, well done",
					"audio": "emma_02"
				},
				{
					"subject": "game",
					"action": "emit_signal",
					"signal": "on_complete",
				}
			],
			"err": [
				{
					"subject": "wingman",
					"action": "say",
					"message": "Shiver me timbers, matey! Ye can't be forgettin' a lady's name! It be Emma",
					"audio": "emma_03"
				},
			]
		},
	]



