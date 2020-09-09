extends Node2D
var checked = preload("res://assets/PauseMenu/com_check.png")
var unchecked = preload("res://assets/PauseMenu/sem_check.png")

func _ready():
	pass

func _on_Pause_pressed():
	var checkboxes = get_parent().get_parent().get_node("Controlers").get_node("PauseMenu").get_node("Checkboxes")
	var labels = get_parent().get_parent().get_node("Controlers").get_node("PauseMenu").get_node("Labels")
	var str_format = "missao{i}"
	var sd = Savedata.read()
	var hided = []
	var todo = []
	var done = []
	for game in sd["games"]:
		if game != "rocket":
			if sd["games"][game]["status"] == -1:
				hided.append(game)
			elif sd["games"][game]["status"] == 0:
				todo.append(game)
			elif sd["games"][game]["status"] == 1:
				done.append(game)
		

	for i in range(1, 7, 1):
		if i <= 6- hided.size():
			checkboxes.get_node(str_format.format({"i": i})).set("visibility/visible", true)
			labels.get_node(str_format.format({"i": i})).set("visibility/visible", true)
		else:
			checkboxes.get_node(str_format.format({"i": i})).set("visibility/visible", false)
			labels.get_node(str_format.format({"i": i})).set("visibility/visible", false)
	for i in range(1, done.size() + 1, 1):
		checkboxes.get_node(str_format.format({"i": i})).set_texture(checked)
		labels.get_node(str_format.format({"i": i})).set_text(sd["games"][done[i-1]]["listname"])
	for i in range(done.size() + 1, done.size() + todo.size() + 1, 1):
		checkboxes.get_node(str_format.format({"i": i})).set_texture(unchecked)
		labels.get_node(str_format.format({"i": i})).set_text(sd["games"][todo[i-done.size() - 1]]["listname"])

	get_parent().get_parent().get_node("Controlers").get_node("PauseMenu").set("visibility/visible", true)
	hide()
	get_parent().get_node("Controls").hide()
