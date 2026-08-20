extends CharacterBody2D


@export var speed = 200.0
@export var explosionScene:PackedScene

var explodeY = 600
var direction: Vector2 = Vector2.DOWN


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	
	if global_position.y >= explodeY:
		explode()
		
func explode():
	queue_free()
	var explosion = explosionScene.instantiate()
	explosion.maxRadius = 100
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = global_position
