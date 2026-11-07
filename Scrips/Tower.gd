extends StaticBody2D

@onready var anzeige: Label = $HealthLabel

var Leben := 100.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:

	anzeige.set_text(str(Leben))


func _on_hitbox_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var prj = area as Node2D as BaseProjectile
	if prj != null:
		Leben -= prj.damage
