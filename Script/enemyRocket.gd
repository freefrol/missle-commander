extends CharacterBody2D


@export var speed = 200.0
@export var explodeY = 600

var direction: Vector2 = Vector2.DOWN


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	if position.y >= explodeY:
		explode()
		
func explode():
	queue_free()
