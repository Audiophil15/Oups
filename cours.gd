extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.dooropened.connect(dooropened)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position = $Player.position
	pass

func dooropened() :
	get_tree().change_scene_to_file("res://cantine.tscn")
