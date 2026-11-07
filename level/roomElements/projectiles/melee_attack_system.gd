class_name MeleeAttackSystem
extends Node2D

@onready var attack_range_c2d: CollisionShape2D = $AttackRange/CollisionShape2D
@onready var disable_timer: Timer = $DisableTimer


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_attack_time_timeout() -> void:
	attack_range_c2d.disabled = false
	disable_timer.start()


func _on_disable_timer_timeout() -> void:
	attack_range_c2d.disabled = true
