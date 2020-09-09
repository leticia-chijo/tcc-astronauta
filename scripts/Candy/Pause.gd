extends Node2D

func _on_Return_pressed():
	get_node("Anim").play("hide")
	yield(get_node("Anim"), "finished")
	Transition.clear_above()

func _on_Home_pressed():
	get_node("Anim").play("hide")
	yield(get_node("Anim"), "finished")
	Transition.fade_to("res://scenes/Mapas/Shopping.tscn")
	Transition.clear_above()

func _on_Replay_pressed():
	get_node("Anim").play("hide")
	yield(get_node("Anim"), "finished")
	Transition.fade_to("res://scenes/Candy/Level.tscn")
	Transition.clear_above()
