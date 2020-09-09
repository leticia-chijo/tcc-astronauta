extends Sprite

export(String, FILE) var starOn

var points = 0
var p3 = 200
var p1 = (725/1875.0)*p3
var p2 = (p1+p3)/2

func _ready():
	starOn = load(starOn)

func set_max(pmax):
	p3 = 200.0
	p1 = (725/1875.0)*p3
	p2 = (p1+p3)/2

func _on_Candies_add_points( p ):
	points += p
	if points > p3: points = p3
	get_node("Blue").set_region_rect(Rect2(0,0,1875*points/p3, 300))
	
	if points >= p3:
		Global.stars = 3
		get_node("Star3").set_texture(starOn)
	elif points >= p2:
		Global.stars = 2
		get_node("Star2").set_texture(starOn)
	elif points >= p1:
		Global.stars = 1
		get_node("Star1").set_texture(starOn)

func win():
	var sd = Savedata.read()
	sd["games"]["candy"]["status"] = 1
	Savedata.save(sd)
	
	return points >= p1

func rmax():
	return points >= p3

