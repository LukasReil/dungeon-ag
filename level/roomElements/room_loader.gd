class_name RoomLoader

extends Node


@export_category("Enemy Spawn Config")
@export var ENEMY_SPAWNER_TEMPLATE: PackedScene

@export var ENEMY_SPAWNERS: Array[int]
@onready var ENEMY_SPAWNER_COUNT = ENEMY_SPAWNERS.size()

@export var ENEMY_SPAWNER_TOP_BOUND: Node2D
@export var ENEMY_SPAWNER_BOTTOM_BOUND: Node2D

@export_category("Player")
@export var ENTRY: Node2D
@export var PLAYER_TEMPLATE: PackedScene

signal player_entered_enemy_spawner(index: int)

var loaded_enemy_spawners : Array[EnemySpawner] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#region Export Asserts
	assert(ENEMY_SPAWNER_COUNT > 0, "No Enemy Spawners provided")
	assert(ENEMY_SPAWNER_TEMPLATE != null, "No Enemy Spawner Template provided")
	#endregion
	
	
	for i in range(ENEMY_SPAWNER_COUNT):
		var enemy_spawner_config = ENEMY_SPAWNERS[i]
		var enemy_spawner_instance = ENEMY_SPAWNER_TEMPLATE.instantiate()
		var spawner_position = _calculate_spawner_position(i)
		enemy_spawner_instance.name = "EnemySpawner_{0}".format([i])
		enemy_spawner_instance.init(spawner_position, i)
		add_child(enemy_spawner_instance)
		enemy_spawner_instance.player_entered_enemy_spawner.connect(func lambda(index): player_entered_enemy_spawner.emit(index))
		loaded_enemy_spawners.append(enemy_spawner_instance as EnemySpawner)


	spawn_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _calculate_spawner_position(index: int) -> Vector2:
	if ENEMY_SPAWNER_COUNT <= 1:
		return (ENEMY_SPAWNER_TOP_BOUND.position + ENEMY_SPAWNER_BOTTOM_BOUND.position) * 0.5
	
	var delta = ENEMY_SPAWNER_BOTTOM_BOUND.position - ENEMY_SPAWNER_TOP_BOUND.position
	var step = delta / (ENEMY_SPAWNER_COUNT - 1)
	return ENEMY_SPAWNER_TOP_BOUND.position + index * step
	
func spawn_player() -> void:
	if PLAYER_TEMPLATE == null:
		push_warning("Not Player Template supplied!")
		return
	
	var player_instance = PLAYER_TEMPLATE.instantiate()
	player_instance.init(ENTRY.global_position)
	add_child(player_instance)
	
