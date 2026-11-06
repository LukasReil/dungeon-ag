extends CharacterBody2D

@onready var leben: Label = $Leben

enum State {idle,move,running}
var state = State.idle
var HP: float = 100.0 

const SPEED = 10000.0
const RSPEED = 20000.0


func init(cordinate):
	position = cordinate
	return 0



func _physics_process(delta: float) -> void:
	
	var Sprint := Input.is_action_pressed("Sprint-key")
	var direction := Input.get_vector("Links", "Rechts","Hoch","Runter")
	
	
	if (direction.x != 0 or direction.y != 0) and not Sprint:
		state = State.move
	elif (direction.x != 0 or direction.y != 0) and Sprint:
		state = State.running
	else:
		state = State.idle
	
	
	if state == State.move:
		velocity.x = direction.x * SPEED * delta
		velocity.y = direction.y * SPEED * delta
	elif state == State.running:
		velocity.x = direction.x * RSPEED * delta 
		velocity.y = direction.y * RSPEED * delta 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	leben.set_text(str(HP))
	move_and_slide()
