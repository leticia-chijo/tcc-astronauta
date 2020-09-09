extends ProgressBar

func _ready():
	pass

func _on_Spinner_speed( valor ):
	set_value(valor*get_max())
