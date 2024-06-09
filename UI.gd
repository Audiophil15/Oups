extends Control

var queue = []
var printing
var charprop #= 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible_ratio = 0
	self.text = ""
	self.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("t: ", self.text)
	if self.visible_ratio == 0 and len(queue) :
		self.text = queue.pop_front()
		charprop = 1.0/len(self.text)
		self.visible = true
	if self.visible_ratio >= 1 and Input.is_action_just_pressed("pl-steal") :
		self.text = ""
		self.visible_ratio = 0
		self.visible = false
		get_tree().paused = false
	if self.visible_ratio < 1 and self.text != "" :
		self.visible_ratio += charprop
		get_tree().paused = true
		#if Input.is_action_just_pressed("pl-steal") :
			#self.visible_ratio = 1
		

func queuetext(text) :
	queue.append(text)

