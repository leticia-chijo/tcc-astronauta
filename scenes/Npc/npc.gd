extends Area2D
var dentro_da_area = false

func _on_npc_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area = true
	
func _on_npc_body_exit( body ):
	if body.get_name() == "personagem":
		dentro_da_area = false

func _on_TouchScreenButton_pressed():
	if dentro_da_area == true:
		Transition.put_above("res://scenes/Npc/DialogBox.tscn")
 