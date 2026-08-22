class_name missileSilo
extends Node2D

@export var reloadTime = 3
@export var firePoint: Marker2D

signal readySilos(silo:missileSilo)

var time = 0
var isReady = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if isReady:
		return
		
	time += delta
	
	if time >= reloadTime:
		isReady = true
		time = 0
		readySilos.emit(self)
		
func restartSilos():
		isReady = false
