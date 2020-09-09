extends CanvasLayer

var next_path

func fade_to(path):
	next_path = path
	get_node("anim").play("fade")

func change_scene():
	if next_path != null:
		get_tree().change_scene(next_path)