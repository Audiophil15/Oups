extends CharacterBody2D

@export var dialog = []

signal pnjspeak(text)

func _ready() :
	$"/root/Global".pnjsID.append(self.get_instance_id())

func speak() :
	emit_signal("pnjspeak", dialog)
