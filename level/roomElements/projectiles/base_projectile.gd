class_name BaseProjectile
extends Node2D

signal projectile_destroyed(uid: int)

@export var damage: float
@export var pierce: float = INF

var uid: int

func init(uid: int) -> void:
	self.uid = uid
	
func hit(hardness: float) -> void:
	pierce -= hardness
	if pierce <= 0:
		projectile_destroyed.emit(uid)
		_on_projectile_destroyed()
		queue_free()
		
func _on_projectile_destroyed() -> void:
	pass
