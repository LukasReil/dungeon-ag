class_name RoomScene
extends Node2D

@export var ROOM_LOADER : RoomLoader

signal player_entered_enemy_spawner(index: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(ROOM_LOADER != null, "Not Room Loader attached!")
	ROOM_LOADER.player_entered_enemy_spawner.connect(func lambda(index: int): player_entered_enemy_spawner.emit(index))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
