extends "Ghost.gd"
func calc_move_normal():
	var aux = destdisc - pacman.destdisc
	if aux.length() >= 5:
		var dest
		for i in range(4, -1, -1):
			dest = pacman.destdisc + pacman.dir*i*-1
			if tilemap.get_cell(dest.x, dest.y) != 2 and dest.x >= 0 and dest.x <= 18 and dest.y >= 0 and dest.y <= 20:
				path = tilemap.find_path(dest, destdisc)
				break
	else:
		path = tilemap.find_path(pacman.destdisc, destdisc)

