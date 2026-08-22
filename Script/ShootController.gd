# shoot_controller.gd
extends Node2D

@export var rocket_scene: PackedScene
@export var fire_delay := 0.5
@export var silos: Array[Node]

var is_shooting = false  # флаг стрельбы
var readySilos : Array[missileSilo]

func _ready() -> void:
	for silo in silos:
		silo.readySilos.connect(siloChangedReady)
		if silo.isReady:
			readySilos.append(silo)
			
		
func siloChangedReady(silo:missileSilo):
	if not silo.isReady:
		return
		
	if not readySilos.has(silo):
		readySilos.append(silo)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if readySilos.size() > 0:
			var targetPosition = get_global_mouse_position()
			var silo = get_nearest_silo(targetPosition)
			readySilos.erase(silo)
			silo.restartSilos()
			shoot(silo, targetPosition)


func shoot(silo:missileSilo, target_position: Vector2):
	var rocket = rocket_scene.instantiate()
	rocket.target_position = target_position
	rocket.global_position = silo.firePoint.global_position  # или позиция игрока
	get_parent().add_child(rocket)
		

func get_nearest_silo(target_position: Vector2) -> missileSilo:
	if readySilos.is_empty():
		return null
						
	var nearest = readySilos[0]
	var min_dist = nearest.firePoint.global_position.distance_squared_to(target_position)
									
	for silo in readySilos:
		var dist = silo.firePoint.global_position.distance_squared_to(target_position)
		if dist < min_dist:
			min_dist = dist
			nearest = silo
																							
	return nearest
