extends Node2D

signal on_complete

var is_seasalt_talking = false

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
			engine.show()
			print('waiting on_complete')
			yield(engine, "on_complete")
			print('done waiting on_complete')
		convo_idx += 1
		convo_step_in_progress = false
		
func handle_wingman_say(step):
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
	
func _on_LevelEngine_on_wrong():
	if responses_to_wrong_input != null and not is_seasalt_talking:
		var step = responses_to_wrong_input[0]
		handle_wingman_say(step)
		yield(speech_timer, "timeout")

func _on_SeaSalt_on_finish_talking():
	is_seasalt_talking = false


func get_convo():
	return [
		{
			"subject": "wingman",
			"action": "say",
			"message": "Now, me heartie, it's time to go all in and tell her ye love her, arr!",
			"audio": "love_01"
		},
		{
			"subject": "wingman",
			"action": "say",
			"message": "Love be the treasure we all seek! Go ahead, tell her!",
			"audio": "love_02"
		},
		{
			"subject": "player",
			"action": "input",
			"ok": [
				{
					"subject": "wingman",
					"action": "say",
					"message": "Ye be fearless like a true pirate!",
					"audio": "love_03"
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
					"message": "Ye strayed off course there. Give it another go",
					"audio": "love_04"
				},
			]
		},
	]



