extends Node
var brinquedo = preload("res://scenes/Brinquedos/brinquedo.tscn")
onready var brinquedos = get_node("brinquedos")
onready var empty_ladder = get_node("empty_ladder")

onready var end = get_node("end")
var brinquedos_names
var percentage_time
var lose

func _ready():
	randomize()
	start()

func start():
	end.get_node("won").set("visibility/visible", false)
	end.get_node("won").set_scale(Vector2(0, 0))
	end.get_node("lose").set("visibility/visible", false)
	end.get_node("lose").set_scale(Vector2(0, 0))
	
	
	brinquedos_names = []
	percentage_time = 100
	lose = false
	get_node("yes").hide()
	get_node("no").hide()
	get_node("ProgressBar").hide()
	var start_anim = get_node("start/AnimationPlayer")
	start_anim.play("start")
	yield(start_anim, "finished")
	generate_toys(50)
	get_node("yes").show()
	get_node("no").show()
	get_node("ProgressBar").show()
	get_node("microtimer").start()
	
func end():
	get_node("microtimer").stop()
	if lose:
		on_lose()
	else:
		on_won()
		
func on_won():
	var sd = Savedata.read()
	sd["games"]["timber"]["status"] = 1
	Savedata.save(sd)
	
	end.get_node("won").set("visibility/visible", true)
	var anim = end.get_node("AnimationPlayer")
	anim.play("won")	
	yield(anim, "finished")
	
func on_lose():
	end.get_node("lose").set("visibility/visible", true)
	var anim = end.get_node("AnimationPlayer")
	anim.play("lose")	
	yield(anim, "finished")
	
	
func descer():
	for b in brinquedos.get_children():
		b.set_pos(b.get_pos() + Vector2(0, 248))
	for e in empty_ladder.get_children():
		e.set_pos(e.get_pos() + Vector2(0, 248))

func generate_toys(toys_number):
	var novo
	var toy_type
	var sprites = [
		preload("res://assets/Brinquedos/basketball.png"),
		preload("res://assets/Brinquedos/block.png"),
		preload("res://assets/Brinquedos/car.png"),
		preload("res://assets/Brinquedos/crown.png"),
		preload("res://assets/Brinquedos/dinosaur.png"),
		preload("res://assets/Brinquedos/doll1.png"),
		preload("res://assets/Brinquedos/doll2.png"),
		preload("res://assets/Brinquedos/doll3.png"),
		preload("res://assets/Brinquedos/flower.png"),
		preload("res://assets/Brinquedos/game-console.png"),
		preload("res://assets/Brinquedos/refrigerator.png"),
		preload("res://assets/Brinquedos/robot.png"),
		preload("res://assets/Brinquedos/stove.png"),
		preload("res://assets/Brinquedos/teddybear.png"),
		preload("res://assets/Brinquedos/train.png"),
	]
	for i in range(toys_number):
		toy_type = int(rand_range(0, 15))
		novo = brinquedo.instance()
		novo.set_index(i)
		novo.set_sprite(sprites[toy_type])
		novo.set_pos(Vector2(400, 1225 - 248*i))
		brinquedos.add_child(novo)
		brinquedos_names.push_back(novo.get_name())
	for i in range(toys_number, toys_number + 6):
		novo = brinquedo.instance()
		novo.set_index(i)
		novo.set_empty()
		novo.set_pos(Vector2(400, 1225 - 248*i))
		empty_ladder.add_child(novo)


func _on_no_button_pressed():
	get_node("yes").hide()
	get_node("no").hide()
	
	if lose == false:
		lose = true
	
	get_node("ProgressBar").set("visibility/visible", false)
	var brinquedo = get_node("brinquedos").get_node(brinquedos_names[0])
	var animation = brinquedo.get_node("AnimationPlayer")
	animation.play("no")
	yield(animation, "finished")
	descer()
	brinquedo.queue_free()
	brinquedos_names.remove(0)
	if brinquedos_names.size() == 0:
		end()
		return
	percentage_time = 100
	get_node("yes").show()
	get_node("no").show()
	get_node("ProgressBar").set_value(percentage_time)
	get_node("ProgressBar").set("visibility/visible", true)
	
func _on_yes_button_pressed():
	get_node("yes").hide()
	get_node("no").hide()
	
	get_node("ProgressBar").set("visibility/visible", false)
	var brinquedo = get_node("brinquedos").get_node(brinquedos_names[0])
	var animation = brinquedo.get_node("AnimationPlayer")
	animation.play("yes")
	yield(animation, "finished")
	descer()
	brinquedo.queue_free()
	brinquedos_names.remove(0)
	if brinquedos_names.size() == 0:
		end()
		return
	get_node("yes").show()
	get_node("no").show()
	percentage_time = 100
	get_node("ProgressBar").set_value(percentage_time)
	get_node("ProgressBar").set("visibility/visible", true)

func _on_microtimer_timeout():
	percentage_time -= 0.5
	get_node("ProgressBar").set_value(percentage_time)
	
	if percentage_time <= 0:
		lose = true
		get_node("yes").hide()
		get_node("no").hide()
		
		get_node("microtimer").stop()
		get_node("ProgressBar").set("visibility/visible", false)
		var brinquedo = get_node("brinquedos").get_node(brinquedos_names[0])
		var animation = brinquedo.get_node("AnimationPlayer")
		animation.play("none")
		yield(animation, "finished")
		descer()
		brinquedo.queue_free()
		brinquedos_names.remove(0)
		if brinquedos_names.size() == 0:
			end()
			return
		get_node("yes").show()
		get_node("no").show()
		percentage_time = 100
		get_node("ProgressBar").set_value(percentage_time)
		get_node("ProgressBar").set("visibility/visible", true)
		get_node("microtimer").start()


func _on_playagain_button_pressed():
	for c in empty_ladder.get_children():
		c.queue_free()
	start()

func _on_backtomap_button_pressed():
	Transition.fade_to("res://scenes/Mapas/Shopping.tscn")

func _on_backtomap_pressed():
	Transition.fade_to("res://scenes/Mapas/Shopping.tscn")
