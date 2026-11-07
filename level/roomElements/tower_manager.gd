class_name TowerManager
extends Node

signal tower_added(pos: Vector2)
signal tower_removed(pos: Vector2)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tower_removed(tower: Tower):
	tower_removed.emit(tower.position)

func _on_child_exiting_tree(node: Node) -> void:
	var tower = node as Tower
	if tower != null:
		_on_tower_removed(tower)

func get_current_tower_positions() -> Array[Vector2]:
	var result: Array[Vector2]
	result.assign(get_children().map(func lambda(node): return node.position))
	return result
