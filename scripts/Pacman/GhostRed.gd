extends "Ghost.gd"
func calc_move_normal():
	path = tilemap.find_path(pacman.destdisc, destdisc)
