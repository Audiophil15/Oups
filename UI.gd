extends Control

var queue = []
var printing
var charprop #= 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Dialog Box".visible_ratio = 0
	$"Dialog Box".text = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"Dialog Box".visible_ratio == 0 and len(queue) :
		$"Dialog Box".text = queue.pop_front()
		charprop = 1/len($"Dialog Box".text)
		print("##", charprop)
		$"Dialog Box".visible = true
	if $"Dialog Box".visible_ratio < 1 and $"Dialog Box".text != "" :
		$"Dialog Box".visible_ratio += charprop
		get_tree().paused = true
	if $"Dialog Box".visible_ratio >= 1 and Input.is_action_just_pressed("ui_accept") :
		$"Dialog Box".text = ""
		$"Dialog Box".visible_ratio = 0
		$"Dialog Box".visible = false
		get_tree().paused = false
		

func queuetext(text) :
	queue.append(text)

