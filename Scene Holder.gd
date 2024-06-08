extends Control

var cantine
#var player

# Called when the node enters the scene tree for the first time.
func _ready():
	#cantine = preload("res://cantine.tscn")
	#player = preload("res://player.tscn")
	get_tree().change_scene_to_file("res://cantine.tscn")
	#add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
