extends CharacterBody2D

var vel = Vector2(0,0)
var speed = 2500
var stealable = []
var items=[]
var enemiesdetected
var canescape

# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Global".playerID = self.get_instance_id()
	enemiesdetected = 0
	canescape = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	velocity = Vector2(0,0)
	
	#$Detection/Up.disabled = true
	#$Detection/Down.disabled = true
	#$Detection/Left.disabled = true
	#$Detection/Right.disabled = true
	
	if Input.is_action_pressed("pl-right") :
		velocity.x = 1
		direction("right")
		#$Detection/Right.disabled = false
	if Input.is_action_pressed("pl-left") :
		velocity.x = -1
		#$Detection/Left.disabled = false
		direction("left")
	if Input.is_action_pressed("pl-down") :
		velocity.y = 1
		#$Detection/Down.disabled = false
		direction("down")
	if Input.is_action_pressed("pl-up") :
		velocity.y = -1
		#$Detection/Up.disabled = false
		direction("up")
	velocity = velocity.normalized()
	
	velocity *= delta*speed
	
	if velocity.length() != 0 :
		$AnimatedSprite2D.play("Run")
	else :
		$AnimatedSprite2D.play("Idle")

	position+=velocity
	
	if Input.is_action_just_pressed("pl-steal") and len(stealable) :
		items.append(stealable[0].getStolen())
	
	print(stealable, items)


func _on_detection_body_entered(body):
	if body.get_instance_id() in $"/root/Global".enemiesID :
		stealable.append(body)

func _on_detection_body_exited(body):
	if body.get_instance_id() in $"/root/Global".enemiesID :
		var i = stealable.bsearch(body)
		stealable.remove_at(i)

func direction(dir) :
	$Detection/Right.disabled = (dir != "right")
	$Detection/Left.disabled = (dir != "left")
	$Detection/Down.disabled = (dir != "down")
	$Detection/Up.disabled = (dir != "up")
	
