class_name WaveManager
extends Node

@export var POSSIBLE_ENEMIES : Array[PackedScene]

@onready var RNG : RandomNumberGenerator = RandomNumberGenerator.new()

signal start_wave


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_wave_start_timer_timeout() -> void:
	start_wave.emit()
	
func spawn_enemy(enemy_template: PackedScene, init_position: Vector2) -> void:
	var enemy = enemy_template.instantiate()
	enemy.init(init_position)
	(enemy as Feind).zielsetzen([Vector2(100.0, 100.0)])
	add_child(enemy)
