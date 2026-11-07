class_name Feind
extends CharacterBody2D

@onready var nav2d: NavigationAgent2D = $NavigationAgent2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var health_label: Label = $HealthLabel

enum States {idle,moving,attacking}
var ziel : Vector2 = Vector2.INF
var Zielrichtung : Vector2
var state = States.idle
var bewegungrutsch: int = 500
const SPEED : int = 9000
var Leben : float = 100.0

func init(spawn_position : Vector2) -> void:
	global_position = spawn_position

func zielsetzen(punkte: Array[Vector2], zerstoert : Vector2 = Vector2.INF):
	
	if ziel != Vector2.INF && ziel != zerstoert:
		return
	
	var minddist : float = INF
	var minddist_vec : Vector2 = Vector2.ZERO
	
	for punkt in punkte:
		var delta = global_position - punkt
		var dist = delta.length()
		if dist < minddist:
			minddist = dist
			minddist_vec = punkt
	
	if minddist != INF:
		ziel = minddist_vec
	else:
		ziel = Vector2.INF
	

func _process(delta: float) -> void:
	if velocity.x > 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	
	if position != ziel:
		state = States.moving
		nav2d.target_position = ziel
		navigate()
	else:
		state = States.idle
		
	health_label.set_text(str(Leben))
	


func _physics_process(delta: float) -> void:
	
	if state == States.moving:
		velocity = Zielrichtung * SPEED * delta
		
	
	if state == States.idle:
		velocity.x = move_toward(velocity.x,0,bewegungrutsch)
		velocity.y = move_toward(velocity.y,0,bewegungrutsch)
	
	move_and_slide()

func navigate():
	if nav2d.is_navigation_finished():
		return
	var next_wegpunkt = nav2d.get_next_path_position()
	Zielrichtung = global_position.direction_to(next_wegpunkt)


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area == StaticBody2D:
		state = States.attacking
	
	
	
	#Navicod
	
	
	#pass # Replace with function body.


func _on_hitbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var proj = area as Node2D as BaseProjectile
	if proj == null:
		return
	
	Leben -= proj.damage
	
	if Leben <= 0:
		queue_free()
