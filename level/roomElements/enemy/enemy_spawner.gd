class_name EnemySpawner

extends Node2D

signal player_entered_enemy_spawner(index: int)

var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Spawned new Enemy Spawner")

func init(spawn_position: Vector2, index: int) -> void:
	global_position = spawn_position
	self.index = index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawner_player_detector_body_entered(body: Node2D) -> void:
	player_entered_enemy_spawner.emit(self.index)
