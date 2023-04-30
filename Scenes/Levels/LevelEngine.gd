extends Node2D

signal on_complete
signal on_wrong

onready var speech_bubble = $SpeechBubble
onready var smithy = $Smithy
onready var wrong_answer_timer: Timer = $WrongAnswerTimer
onready var on_complete_timer: Timer = $OnCompleteTimer
var window = JavaScript.get_interface('window');

export var goal: String = "love you"
export var grammar: String = "love"
export var available_phonemes = ['a', 'ʟ', 'v', 'ɨ']

var wrong_answer_debounce_time = OS.get_unix_time()
var correct_answer_debounce_time = OS.get_unix_time()

var is_grammar_loaded = false

func _ready():
	print('phonemes: ', available_phonemes)
	print('goal: ', goal)
	smithy.available_phonemes = available_phonemes
	smithy.init()


func _physics_process(delta):
	if not is_grammar_loaded:
		if window != null and not window.document.getElementById("sendButtonPhonemes").disabled:
			print('loading grammar ', grammar)
			window.refreshGrammar(str(grammar))
			is_grammar_loaded = true

	if window != null:
		var hyp = window.document.getElementById("output").innerHTML
		speech_bubble.text = hyp
		if hyp != null and hyp != '':
			var goal_words = goal.split(' ')
			var words = hyp.split(' ')
			
			if wrong_answer_timer.is_stopped():
				wrong_answer_timer.wait_time = 3
				wrong_answer_timer.start()
			
			var num_matches = 0
			for word in words:
#				print('checking: ', word.to_lower(), ' in ', goal_words)
				if word.to_lower() in goal_words:
					num_matches += 1
#			print('num_matches ', num_matches)
			if len(words) > 0 and ((num_matches + 0.0) / len(words)) >= 0.5:
				print('num matches: ', num_matches, ' len words: ', len(words), ' words: ', words)
				var current_unix_time = OS.get_unix_time()
				if current_unix_time - correct_answer_debounce_time > 10 and on_complete_timer.time_left == 0:
					print('level engine on_complete queued')
					on_complete_timer.start()
					



func _on_WrongAnswerTimer_timeout():
	if on_complete_timer.time_left > 0:
		return
	var current_unix_time = OS.get_unix_time()
	print('get on_wrong ', current_unix_time, ' ', wrong_answer_debounce_time)
	if current_unix_time - wrong_answer_debounce_time > 10:
		emit_signal("on_wrong")
		wrong_answer_debounce_time = OS.get_unix_time()
		if window != null:
			window.document.getElementById("output").innerHTML = ''


func _on_OnCompleteTimer_timeout():
	emit_signal("on_complete")
	correct_answer_debounce_time = OS.get_unix_time()
