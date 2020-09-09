extends Area2D

func _on_moeda_body_enter( body ):
	body.moeda()
	get_node("anim").play("coletar")
	get_node("shape").queue_free()
	yield(get_node("anim"),"finished")
	queue_free() 
 