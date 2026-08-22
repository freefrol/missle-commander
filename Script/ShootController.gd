# shoot_controller.gd
extends Node2D

@export var rocket_scene: PackedScene
@export var rocketPosition: Marker2D
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
			shoot()


func shoot():
	var silo = readySilos.pop_front()
	silo.restartSilos()
	
	var rocket = rocket_scene.instantiate()
	rocket.target_position = get_global_mouse_position()
	rocket.global_position = rocketPosition.global_position  # или позиция игрока
	get_parent().add_child(rocket)
	is_shooting = false
		
