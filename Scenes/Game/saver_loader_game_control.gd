class_name SaverLoaderGameControl extends BasicControl
@onready var load_button: Button = %LoadButton
@onready var save_button: Button = %SaveButton

func _ready():
	connection_map = [
		[load_button.pressed, SignalBus.saverloader.emit.bind(SaverLoader.Action.LOAD_GAME)],
		[save_button.pressed, SignalBus.saverloader.emit.bind(SaverLoader.Action.SAVE_GAME)]
	]
	connect_signals()
