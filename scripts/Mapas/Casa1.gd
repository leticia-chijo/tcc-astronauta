extends Node2D

func _ready():
	pass


func _on_Door_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")
