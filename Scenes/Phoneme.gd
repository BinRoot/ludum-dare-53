extends Node2D

onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
onready var label: Label = $Button/Label
onready var button: Button = $Button
onready var glow = $Glow

var is_drag_and_drop_mode = false
var file: String

var rotate_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_direction = (randi() % 2) * 2 - 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_drag_and_drop_mode:
		position = get_global_mouse_position()
	glow.rect_rotation += rotate_direction * delta * (randi() % 100)

func set_audio(_file):
	file = _file
	audio_player.stream = load("res://Assets/Audio/Phonemes/" + _file + ".ogg")



func _on_Button_button_down():
	is_drag_and_drop_mode = true
	audio_player.play()


func _on_Button_button_up():
	is_drag_and_drop_mode = false


func _on_Area2D_area_entered(area):
	if area.is_in_group('playhead_area'):
		button.modulate = Color.green
		audio_player.play()

func _on_Area2D_area_exited(area):
	if area.is_in_group('playhead_area'):
		button.modulate = Color.white

func _on_Button_pressed():
	#audio_player.play()
	pass



