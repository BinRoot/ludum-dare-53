extends Node2D

signal on_complete

var convo
var convo_idx = 0
var convo_step_in_progress = false
var responses_to_wrong_input
var responses_to_correct_input

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
			print('waiting on_complete')
			engine.show()
			yield(engine, "on_complete")
			print('done waiting on_complete')
		convo_idx += 1
		convo_step_in_progress = false
		
		
func handle_wingman_say(step):
	if speech_timer.is_stopped():
		var message = step['message']
		sea_salt.talk(step)
		speech_bubble.text = message
		speech_timer.wait_time = Globals.convo_wait_duration
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
	
func _on_LevelEngine_on_wrong():
	if responses_to_wrong_input != null:
		var step = responses_to_wrong_input[0]
		handle_wingman_say(step)
		yield(speech_timer, "timeout")


func get_convo():
	return [
		{
			"subject": "wingman",
			"action": "say",
			"message": "Good luck on yer first date!",
			"audio": "yesno_01"
		},
		{
			"subject": "wingman",
			"action": "say",
			"message": "Aye be yer trusty wingman.",
			"audio": "yesno_02"
		},
		{
			"subject": "wingman",
			"action": "say",
			"message": "She'll be dockin' her ship any moment now.",
			"audio": "yesno_03"
		},
		{
			"subject": "wingman",
			"action": "say",
			"message": "Be ye prepared to set sail?",
			"audio": "yesno_04"
		},
		{
			"subject": "player",
			"action": "input",
			"ok": [
				{
					"subject": "wingman",
					"action": "say",
					"message": "There she is!",
					"audio": "yesno_05"
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
					"message": "We don't got all day. Ye ready or not?",
					"audio": "yesno_06"
				},
			]
		},
	]



