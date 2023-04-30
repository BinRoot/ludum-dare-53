extends Node2D

onready var level_holder = $LevelHolder
onready var start_button = $StartButton
onready var background_flow = $BackgroundGlow

var levels = [
	preload("res://Scenes/Levels/YesNoLevel.tscn"),
	preload("res://Scenes/Levels/HiLevel.tscn"),
	preload("res://Scenes/Levels/EmmaLevel.tscn"),
	preload("res://Scenes/Levels/ComplimentLevel.tscn"),
	preload("res://Scenes/Levels/LoveLevel.tscn")
]

var current_level_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	background_flow.rect_rotation += 0.05
	
	background_flow.rect_position.x += 2 * sin(background_flow.rect_position.x)
	background_flow.rect_position.y += 2 * cos(background_flow.rect_position.y)

func set_level():
	if current_level_idx >= len(levels):
		print('level out of bounds')
		return
	var scene = levels[current_level_idx]
	for child in level_holder.get_children():
		level_holder.remove_child(child)
		child.queue_free()
	var scene_inst = scene.instance()
	level_holder.add_child(scene_inst)
	scene_inst.connect('on_complete', self, 'on_level_complete')

func on_level_complete():
	print('on complete in level controller')
	current_level_idx += 1
	set_level()


func _on_StartButton_pressed():
	start_button.hide()
	set_level()
