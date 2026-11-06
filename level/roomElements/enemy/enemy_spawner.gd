class_name EnemySpawner

extends Node2D

@onready var wave_manager: WaveManager = $"../../WaveManager"
@onready var enemy_spawner_timer: Timer = $EnemySpawnerTimer


signal player_entered_enemy_spawner(index: int)

var index: int = 0
var registered_enemy_templates : Array[PackedScene]

var wave_running : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	registered_enemy_templates = wave_manager.POSSIBLE_ENEMIES
	assert(registered_enemy_templates.size() > 0, "No Enemies registered")
	wave_manager.start_wave.connect(_on_start_wave)
	
func init(spawn_position: Vector2, index: int) -> void:
	global_position = spawn_position
	self.index = index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawner_player_detector_body_entered(body: Node2D) -> void:
	player_entered_enemy_spawner.emit(self.index)
	
	
func _on_start_wave() -> void:
	wave_running = true
	enemy_spawner_timer.start()

func try_spawn_enemy() -> void:
	wave_manager.spawn_enemy(registered_enemy_templates[wave_manager.RNG.randi_range(0, registered_enemy_templates.size() - 1)], global_position)

func _on_enemy_spawner_timer_timeout() -> void:
	if wave_running:
		try_spawn_enemy()
