extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _on_Door_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")
