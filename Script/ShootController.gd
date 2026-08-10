# shoot_controller.gd
extends Node2D

@export var rocket_scene: PackedScene
@export var rocketPosition: Marker2D
@export var fire_delay := 0.5

var is_shooting = false  # флаг стрельбы
var last_shot_time := 0

func _process(delta):
	# Проверяем нажатие кнопки
	is_shooting = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	
	if is_shooting and rocket_scene :
		shoot()


func shoot():
	var current_time = Time.get_ticks_msec()  # Текущее время в миллисекундах
	
	if current_time - last_shot_time >= fire_delay * 1000:
		last_shot_time = current_time
		var rocket = rocket_scene.instantiate()
		rocket.target_position = get_global_mouse_position()
		rocket.global_position = rocketPosition.global_position  # или позиция игрока
		get_parent().add_child(rocket)
		is_shooting = false
		
