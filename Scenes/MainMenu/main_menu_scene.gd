class_name MainMenuScene extends BasicControl

@onready var exit: Button = %EXIT

func _ready():
	connection_map = [
		[exit.pressed, exit_game]
	]
	connect_signals()
	# or
	#connect_signal()

func exit_game():
	get_tree().quit()
	
func _process(_delta):
	pass
