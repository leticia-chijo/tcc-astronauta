extends Node
var saveFile = File.new()
var savePath = "user://savegame.save"
var saveData = {"level1": 0,
				"level2": -1,
				"level3": -1,
				"level4": -1,
				"level5": -1,
				"level6": -1}

var curLevel = 1
var stars = 0

# dialogos npc
var npcAtual = ""
var numText = 0 

#alteracoes por perguntas de npcs
var friendElf = false

func _ready():
	if not saveFile.file_exists(savePath):
		save()
	read()

func save():
	saveFile.open(savePath, File.WRITE)
	saveFile.store_var(saveData)
	saveFile.close()

func read():
	saveFile.open(savePath, File.READ)
	saveData = saveFile.get_var()
	saveFile.close()

func save_level(level, stars):
	if level > 6: return
	saveData["level" + str(level)] = stars
	save()

func set_dialog(npc, nText):
	npcAtual = npc
	numText = nText 