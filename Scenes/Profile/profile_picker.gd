class_name ProfilePicker extends BasicControl

@export var profile_id: int
@onready var slot_name: Label = $SlotName
@onready var activation_button: Button = %ActivationButton

func _ready():
	slot_name.text = tr('SLOT_NUMBER') % str(profile_id)
	profile_text_update()
	connect_signal(activation_button.pressed, _activate_profile_pressed)
	connect_signal(SignalBus.changed_profile, profile_text_update)

func _activate_profile_pressed():
	SignalBus.profile.emit(ProfileSelector.PROFILE_ACTION.CHANGE_PROFILE, profile_id)
			
func profile_text_update():
	if App.user_profile.profile_id == profile_id:
		activation_button.disabled = true
		activation_button.text = tr('ACTIVE')
	else:
		activation_button.disabled = false
		activation_button.text = tr('ACTIVATE')

func _process(_delta):
	pass
