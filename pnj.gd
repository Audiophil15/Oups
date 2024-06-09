extends CharacterBody2D

@export var dialog = []

func _on_ready() :
	$"/root/Global".pnjsID.append(self.get_instance_id())

func speak(text) :
	$UI.queuetext(text)
