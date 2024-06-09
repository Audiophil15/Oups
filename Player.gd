extends CharacterBody2D

signal stolen(item)
signal dooropened
signal speak(pnj)

var vel = Vector2(0,0)
var speed = 2500
var stealable = []
var speakable = []
var doorinrange = []
var items=[]
var enemiesdetected

# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Global".playerID = self.get_instance_id()
	enemiesdetected = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	z_index = int(position.y)

	velocity = Vector2(0,0)
	$Label.visible = false
	var dir = ""

	if Input.is_action_pressed("pl-right") :
		velocity.x = 1
		direction("right")
		dir = "Right"
	if Input.is_action_pressed("pl-left") :
		velocity.x = -1
		direction("left")
		dir = "Left"
	if Input.is_action_pressed("pl-down") :
		velocity.y = 1
		direction("down")
		dir = "Down"
	if Input.is_action_pressed("pl-up") :
		velocity.y = -1
		direction("up")
		dir = "Up"
	velocity = velocity.normalized()

	velocity *= delta*speed

	if velocity.length() != 0 :
		$AnimatedSprite2D.play("Run_" + dir)
	else :
		$AnimatedSprite2D.play("Idle")

	position+=velocity

	if len(stealable) :
		$Label.text = "Steal"
		$Label.visible = true
		if Input.is_action_just_pressed("pl-steal") :
			items.append(stealable[0].getStolen())
			emit_signal("stolen", items[-1])
	if len(doorinrange) :
		$Label.text = "Open"
		$Label.visible = true
		if Input.is_action_just_pressed("pl-steal") :
			emit_signal("dooropened")
	if len(speakable) :
		$Label.text = "Speak"
		$Label.visible = true
		if Input.is_action_just_pressed("pl-steal") :
			print("I want to speak to", speakable[-1])
			emit_signal("speak", speakable[-1])

	#print(stealable, items)
	#print($"/root/Global".pnjsID)
	move_and_slide()

func _on_detection_body_entered(body):
	if body.get_instance_id() in $"/root/Global".enemiesID :
		stealable.append(body)
	if body.get_instance_id() in $"/root/Global".doorsID :
		doorinrange.append(body)
	if body.get_instance_id() in $"/root/Global".pnjsID :
		speakable.append(body)

func _on_detection_body_exited(body):
	if body.get_instance_id() in $"/root/Global".enemiesID :
		var i = stealable.bsearch(body)
		stealable.remove_at(i)
	if body.get_instance_id() in $"/root/Global".doorsID :
		var i = doorinrange.bsearch(body)
		doorinrange.remove_at(i)
	if body.get_instance_id() in $"/root/Global".pnjsID :
		var i = speakable.bsearch(body)
		speakable.remove_at(i)

func direction(dir) :
	$Detection/Right.disabled = (dir != "right")
	$Detection/Left.disabled = (dir != "left")
	$Detection/Down.disabled = (dir != "down")
	$Detection/Up.disabled = (dir != "up")

