extends Node2D

signal on_finish_talking

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = 0
	sprite.play("default")


func idle():
	sprite.frame = 0
	sprite.play("default")
	
	
func talk(step_obj):
	if step_obj != null and 'audio' in step_obj:
		var audio_file = step_obj['audio']
		audio_player.stream = load('res://Assets/Audio/Seasalt/{0}.wav'.format([audio_file]))
		audio_player.play()
		var r = (randi() % 3) + 1
		sprite.frame = 0
		sprite.play("talking_{0}".format([r]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print('audio_player ', audio_player.playing, ', sprite ', sprite.playing)
	pass
	

func _on_AudioStreamPlayer_finished():
	idle()
	emit_signal("on_finish_talking")


func _on_AnimatedSprite_animation_finished():
	if audio_player.playing:
		var r = (randi() % 3) + 1
		sprite.frame = 0
		sprite.play("talking_{0}".format([r]))
