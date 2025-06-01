class_name GamePlanner extends SavegameData

enum PlanetType { MIXED, ROCKY, WATER, FROZEN, LAVA, DESERT }
enum PlanetSize { SMALL, MEDIUM, NORMAL, BIG, LARGE, HUGE }
enum Budget { MINIMAL, LITTLE, SMALL, MEDIUM, BIG, LARGE, HUGE }

@export var planet_type: PlanetType = PlanetType.MIXED
@export var planet_size: PlanetSize = PlanetSize.NORMAL
@export var player_name: String = tr('PLAYER_NAME')
@export var player_budget: Budget = Budget.SMALL
