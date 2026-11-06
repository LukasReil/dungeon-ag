extends StaticBody2D

@onready var kampfreichweite: Area2D = $Kampfreichweite
@onready var c2d: CollisionShape2D = $Kampfreichweite/CollisionShape2D
@onready var anzeige: Label = $Label
@onready var deauer: Timer = $dauer
@onready var startzeit: Timer = $Startzeit

var Leben := 100.0

func _ready() -> void:
	c2d.disabled = true
	startzeit.start()

func _process(delta: float) -> void:

	anzeige.set_text(str(Leben))


func auszeit() -> void:
	c2d.disabled = false
	deauer.start()
	pass # Replace with function body.


func dauer() -> void:
	startzeit.start()
	c2d.disabled = true


func _on_hitbox_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var prj = area as Node2D as BaseProjektil
	if prj != null:
		Leben -= prj.damage
	pass
