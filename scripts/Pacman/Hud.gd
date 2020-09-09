extends Control
onready var label_score = get_node("Score")

var score = 0


func _ready():
	label_score.set_text(str(score))

func add_score(add):
	score += add
	label_score.set_text(str(score))

func set_score(old_score):
	score = old_score
	get_node("Score").set_text(str(score))
