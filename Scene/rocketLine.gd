extends Line2D

@export var max_points := 100

func _physics_process(delta):
	# Ракета — это родительский узел
	var rocket = get_parent()
	
	# Добавляем позицию ракеты
	add_point(rocket.global_position)
	
	# Удаляем старые точки
	if get_point_count() > max_points:
		remove_point(0)
