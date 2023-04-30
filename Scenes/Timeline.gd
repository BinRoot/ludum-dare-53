extends Node2D

signal on_complete

onready var playhead = $Playhead
onready var timeline_texture: TextureRect = $TimelineTexture

var progress = 0

var phonemes = []
var is_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_phonemes():
	for phoneme in get_tree().get_nodes_in_group('phoneme'):
		timeline_texture.position
		pass

func _physics_process(delta):
	playhead.position.x = progress * timeline_texture.rect_size.x
	playhead.position.y = timeline_texture.rect_position.y
	if is_playing:
		progress += delta / 2
		if progress > 1:
			emit_signal("on_complete")
			is_playing = false

func play():
	progress = 0
	is_playing = true

func _on_Area2D_area_entered(area):
	if 'Phoneme' in area.owner.name:
		phonemes.append(area.owner)

func _on_Area2D_area_exited(area):
	if 'Phoneme' in area.owner.name:
		var idx = phonemes.find(area.owner)
		phonemes.remove(idx)
