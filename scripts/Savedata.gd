extends Node2D

var savegame = File.new()
var savepath = "user://astronauta.save"

func save(savedata):
	savegame.open(savepath, File.WRITE)
	savegame.store_var(savedata)
	savegame.close()
	
func read():
	savegame.open(savepath, File.READ)
	var savedata = savegame.get_var()
	savegame.close()
	return savedata