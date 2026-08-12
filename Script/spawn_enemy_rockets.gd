extends Node2D

@export var enemyRoket: PackedScene      # Сцена вражеской ракеты
@export var spawn_interval := 1.5         # Интервал между появлениями (сек)
@export var min_angle := -20.0            # Минимальный угол отклонения (градусы)
@export var max_angle := 20.0             # Максимальный угол отклонения (градусы)
@export var speed := 200.0                # Скорость ракет
@export var spawn_y_offset := -50.0       # Расстояние над экраном (отступ)
@export var explodeOffset := 0.2
var timer := 0.0
var screen_size: Vector2

func _ready():
	# Получаем размер экрана (работает и на мобильных устройствах)
	screen_size = get_viewport().get_visible_rect().size

func _physics_process(delta):
	timer += delta
	if timer >= spawn_interval:
		timer = 0.0
		spawn_enemy()

func spawn_enemy():
	var enemy = enemyRoket.instantiate()
	add_child(enemy)
	
	# Случайная позиция по X в пределах экрана, Y — над экраном
	var x_pos = randf_range(0, screen_size.x/2)
	enemy.global_position = Vector2(x_pos, (-screen_size.y/2)-spawn_y_offset)
	
	# Случайный угол в пределах [min_angle, max_angle]
	
	var targetRandom = Vector2(randf()*(screen_size.x/2), screen_size.y/2)
	var angle_deg = randf_range(min_angle, max_angle)
	var angle_rad = deg_to_rad(angle_deg)
	var direction = (Vector2)(targetRandom - enemy.global_position).normalized() 
	#var direction = Vector2( sin(angle_rad), cos(angle_rad) ).normalized()
	
	# Передаём скорость и направление вражеской ракете
	# Предполагаем, что у EnemyRocket есть переменные speed и direction
	enemy.speed = speed
	enemy.direction = direction
	enemy.explodeY = targetRandom.y * (1-explodeOffset)
