
# rocket.gd
extends CharacterBody2D

@export var speed = 500  # свойство скорость
@export var explodeRadius = 200
@export var explosionScene:PackedScene

var target_position = Vector2.ZERO

func _ready():
	# Двигаемся к цели
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed

func _physics_process(delta):
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		explode()
	
	# Удаляем если прилетели
	if global_position.distance_to(target_position) < 10:
		explode()

func explode():
	queue_free()
	var explosion = explosionScene.instantiate()
	explosion.maxRadius = explodeRadius
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = global_position
	
	
