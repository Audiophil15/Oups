extends CharacterBody2D

var vel = Vector2(0,0)
var speed = 750
var direction
var walking

@export var item = ""

signal playerfound

var directionsprobas = {
	"up":{
		"up":0.925, "down":0.0025, "left":0.0025, "right":0.0025
	},
	"down":{
		"up":0.0025, "down":0.925, "left":0.0025, "right":0.0025
	},
	"left":{
		"up":0.0025, "down":0.0025, "left":0.925, "right":0.0025
	},
	"right":{
		"up":0.0025, "down":0.0025, "left":0.0025, "right":0.925
	}
}

var walkingprobas = {
	"walking":{
		"walking":0.985, "idle":0.015
	},
	"idle":{
		"walking":0.005, "idle":0.995
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	walking = "walking"
	direction = "left"
	
	$"/root/Global".enemiesID.append(self.get_instance_id())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	z_index = int(position.y)
	
	velocity = Vector2(0,0)
	
	if walking == "idle" :
		direction = WeightedChoice.pick(directionsprobas[direction])
	walking = WeightedChoice.pick(walkingprobas[walking])
	#print(direction)
	#print(walking)
	#print()
	
	$Detection/Up.disabled = true
	$Detection/Down.disabled = true
	$Detection/Left.disabled = true
	$Detection/Right.disabled = true
	
	if direction == "right" :
		$Detection/Right.disabled = false
	if direction == "left" :
		$Detection/Left.disabled = false
	if direction == "down" :
		$Detection/Down.disabled = false
	if direction == "up" :
		$Detection/Up.disabled = false

	if walking == "walking" :
		if direction == "right" :
			velocity.x = 1
		if direction == "left" :
			velocity.x = -1
		if direction == "down" :
			velocity.y = 1
		if direction == "up" :
			velocity.y = -1
	velocity = velocity.normalized()
	
	velocity *= delta*speed
	
	if velocity.length() != 0 :
		$AnimatedSprite2D.play("Run_" + direction)
	else :
		$AnimatedSprite2D.play("Idle_" + direction)

	position+=velocity
	move_and_slide()

func getStolen() :
	var r = item
	item = ""
	return r


func _on_detection_body_entered(body):
	print(body, " detected !")
	if body.get_instance_id() == $"/root/Global".playerID :
		print("player found !")
		emit_signal("playerfound")
	pass # Replace with function body.
