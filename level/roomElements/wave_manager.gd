class_name WaveManager
extends Node

@export var POSSIBLE_ENEMIES : Array[PackedScene]

@onready var RNG : RandomNumberGenerator = RandomNumberGenerator.new()
@onready var tower_manager: TowerManager = $"../TowerManager"

signal start_wave


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tower_manager.tower_removed.connect(_on_tower_removed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tower_removed(pos: Vector2) -> void:
	var children = get_children()
	var towers: Array[Vector2] = tower_manager.get_current_tower_positions().filter(func lambda(position: Vector2): return position != pos)
	for child in children:
		var enemy_child = child as Feind
		if enemy_child != null:
			enemy_child.zielsetzen(towers, pos)

func _on_wave_start_timer_timeout() -> void:
	start_wave.emit()
	
func spawn_enemy(enemy_template: PackedScene, init_position: Vector2) -> void:
	var enemy = enemy_template.instantiate()
	enemy.init(init_position)
	(enemy as Feind).zielsetzen(tower_manager.get_current_tower_positions())
	add_child(enemy)
