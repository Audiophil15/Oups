extends StaticBody2D

@export var unlocked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Global".doorsID.append(self.get_instance_id())
	z_index = int(position.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
