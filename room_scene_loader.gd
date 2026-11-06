class_name RoomSceneLoader
extends Node

@export var ROOM_SCENE_TEMPLATE : PackedScene

var current_room: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(ROOM_SCENE_TEMPLATE != null, "No Room Scene Template supplied!")
	
	_load_new_room()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _load_new_room() -> void:
	if current_room != null:
		current_room.queue_free()
		
	current_room = ROOM_SCENE_TEMPLATE.instantiate()
	current_room.player_entered_enemy_spawner.connect(_on_player_entered_enemy_spawner)
	call_deferred("add_child", current_room)
	
func _on_player_entered_enemy_spawner(index: int) -> void:
	print("Player entered {0}".format([index]))
	_load_new_room()
