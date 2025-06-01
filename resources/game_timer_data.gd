class_name GameTimerData extends SavegameData

enum Speed { NORMAL, FAST, FASTER }

@export var ticks: int = 0
@export var realtime: float = 0.0
@export var game_speed: Speed
