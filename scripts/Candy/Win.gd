extends Node2D

export(String, FILE) var starOn

var stars

func _ready():
	stars = Global.stars
	var level = Global.curLevel
	Global.save_level(level, stars)
	
	if Global.saveData["level" + str(level + 1)] == -1:
		Global.save_level(level + 1,0)
	
	if stars >= 2:
		get_node("Star2").set_texture(load(starOn))
	if stars >= 3:
		get_node("Star3").set_texture(load(starOn))

func _on_Replay_pressed():
	get_node("Anim").play("hide")
	yield(get_node("Anim"), "finished")
	Transition.fade_to("res://scenes/Candy/Level.tscn")
	Transition.clear_above()

func _on_Next_pressed():
	get_node("Anim").play("hide")
	yield(get_node("Anim"), "finished")
	Global.curLevel += 1
	var sd = Savedata.read()
	sd["games"]["candy"]["status"] = 1
	sd["games"]["candy"]["score"] = stars
	Savedata.save(sd)
	Transition.fade_to("res://scenes/Mapas/Shopping.tscn")
	Transition.clear_above()
