extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.stolen.connect(playerstoleitem)
	$Player.dooropened.connect(dooropened)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position = $Player.position
	pass

func playerstoleitem(item) :
	$Camera2D/UI.queuetext("Item stolen !")
	$Camera2D/UI.queuetext("You found a "+item+".")
	if item == "key" :
		$Door.unlocked = true

func dooropened() :
	if $Door.unlocked :
		get_tree().change_scene_to_file("res://cours.tscn")
	else :
		$Camera2D/UI.queuetext("You need the key !")

func playerfound() :
	"Signal player is found !"
	get_tree().change_scene_to_file("res://death.tscn")
