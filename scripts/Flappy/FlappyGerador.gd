extends Position2D
onready var game = get_tree().get_current_scene()
onready var cano = preload("res://scenes/Flappy/FlappyCano.tscn")
var count = 1
signal last

func _ready():
	randomize()
	get_node("Timer").start()

func _on_Timer_timeout():
	print(count)
	if count <= game.max_canos:
		var novocano = cano.instance()
		novocano.set_pos(get_pos() + Vector2(0,rand_range(-500,500)))
		get_owner().add_child(novocano)
		count += 1
	if count == game.max_canos:
		print("last")
		emit_signal("last")
		get_node("Timer").stop()

	
