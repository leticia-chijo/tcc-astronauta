extends Node2D

func _ready():
	get_node("balaoNave").hide()
	get_node("personagem/CanvasLayer/Controlers/Pause").hide()
	get_node("Timer").start()


func _on_TouchScreenButton_pressed():
	Transition.fade_to("res://scenes/Rocket/Game.tscn")


func _on_Timer_timeout():
	print("timer")
	Global.set_dialog("controles",0)
	Transition.put_above("res://scenes/Npc/DialogBox.tscn")


func _on_areaMsg_body_enter( body ):
	if body.get_name() == "personagem":
		var sd = Savedata.read()
		sd["npcs"]["controles"]["current_dialog"] = 1 
		sd["npcs"]["controles"]["current_speech"] = 0
		Savedata.save(sd)
		Global.set_dialog("controles",0)
		Transition.put_above("res://scenes/Npc/DialogBox.tscn")
		


func _on_tutorial2_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("tutorial2",0)


func _on_tutorial1_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("tutorial1",0)


func _on_tutorial3_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("tutorial3",0)


func _on_areaBotaoNave_body_enter( body ):
	if body.get_name() == "personagem":
		get_node("balaoNave").show()
		get_node("balaoNave/AnimationPlayer").play("anim")
