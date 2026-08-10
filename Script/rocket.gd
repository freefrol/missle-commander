
# rocket.gd
extends CharacterBody2D

@export var speed = 500  # свойство скорость
var target_position = Vector2.ZERO

func _ready():
	# Двигаемся к цели
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed

func _physics_process(delta):
	move_and_slide()
	
	# Удаляем если прилетели
	if global_position.distance_to(target_position) < 10:
		queue_free()
