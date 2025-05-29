class_name MainMenuScene extends BasicControl

@onready var quit: Button = %QUIT

func _ready():
	connection_map = [
		[quit.pressed, quit_game]
	]
	connect_signals()
	# or
	#connect_signal()

func quit_game():
	get_tree().quit()
	
func _process(_delta):
	pass
