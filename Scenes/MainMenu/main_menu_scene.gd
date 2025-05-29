class_name MainMenuScene extends BasicControl

@onready var quit: Button = %QUIT
@onready var profile: Button = %PROFILE
@onready var settings: Button = %SETTINGS

func _ready():
	connection_map = [
		[quit.pressed, quit_game],
		[settings.pressed, goto_app_settings]
	]
	connect_signals()
	# or
	#connect_signal()

func quit_game():
	get_tree().quit()

func goto_app_settings():
	MainSM.change_to_app_settings_scene()
	
func _process(_delta):
	pass
