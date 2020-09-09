extends RichTextLabel
var sd = Savedata.read()
var sd_npcs = sd["npcs"]
var page
var dialog
var npc_name

func _ready():
	set_process_input(true)

func start(npc):
	npc_name = npc

	dialog = sd_npcs[npc]["dialogs"][sd_npcs[npc]["current_dialog"]]
	page = 0
	sd_npcs[npc]["current_speech"] = page
	sd["npcs"] = sd_npcs
	if typeof(dialog[page]) == TYPE_DICTIONARY:
		Transition.clear_above()
		Transition.put_above("res://scenes/Npc/questionDialog.tscn")
		
	else:
		set_bbcode(dialog[page])
		set_visible_characters(0)
	
func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)

func _on_TouchScreenButton_pressed():
	if get_visible_characters() > get_total_character_count():
		if page < dialog.size() - 1:
			page += 1
			sd_npcs[npc_name]["current_speech"] = page
			sd["npcs"] = sd_npcs
			Savedata.save(sd)
			
			if typeof(dialog[page]) == TYPE_DICTIONARY:
				Transition.clear_above()
				Transition.put_above("res://scenes/Npc/questionDialog.tscn")
			else:
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			if sd["npcs"]["mecanica"]["current_dialog"] == 1:
				sd["npcs"]["mecanica"]["current_dialog"] = 2
				sd["npcs"]["mecanica"]["current_speech"] = 0
				Savedata.save(sd)
				Transition.clear_above()
				Transition.put_above("res://scenes/Npc/DialogBox.tscn")
			else: 
				Transition.clear_above()
	else:
		set_visible_characters(get_total_character_count())
