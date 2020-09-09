extends Node2D

func _ready():
	pass

func _on_Mausoleu_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/CasaVelha.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})
	
func _on_School_body_enter( body ):
	
	Transition.fade_to("res://scenes/Mapas/CasaMecanica.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_Market_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/Mercado.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_Mall_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/Shopping.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_House1_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/Casa1.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_House2_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/Casa2.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_House3_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/Casa3.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_House4_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/CasaGrande.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})

func _on_House5_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/CasaPiscina.tscn", {"personagem_position": body.get_pos() + Vector2(0,30)})
