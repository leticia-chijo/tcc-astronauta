extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Close_pressed():
	get_parent().set("visibility/visible", false)
	get_parent().get_parent().get_node("Pause").show()
	get_parent().get_parent().get_node("Controls").show()