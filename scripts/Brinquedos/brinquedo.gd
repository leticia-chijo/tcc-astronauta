extends Node2D
var index
func _ready():
	pass
	
func set_index(i):
	index = i
func set_sprite(sprite):
	get_node("toy").set_texture(sprite)
func set_empty():
	get_node("toy").set("visibility/visible", false)

func choose(choice):
	if (choice == -1):
		get_node("AnimationPlayer").play("direita")
	else:
		get_node("AnimationPlayer").play("esquerda")