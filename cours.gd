extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print($PNJ)
	$Player.dooropened.connect(dooropened)
	$Player.speak.connect(pnjdialog)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position = $Player.position
	#$UI.position = $Camera2D.position
	pass

func dooropened() :
	get_tree().change_scene_to_file("res://cantine.tscn")

func pnjdialog(pnj) :
	#print("pnj talk")
	for line in $PNJ.dialog :
		#print(line)
		$Camera2D/UI.queuetext(line) 
