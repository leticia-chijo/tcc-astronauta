var aux
func _ready():
	var dif = get_pos() - get_parent().get_node("personagem").get_pos()
	print(dif)
	set_fixed_process(true)

func _fixed_process(delta):
	aux = get_parent().get_node("personagem").get_pos() + dif
	set_pos(get_pos() + aux)
