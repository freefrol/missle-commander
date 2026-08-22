class_name missileSilo
extends Node2D

@export var timer = 3
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
	
	if time >= timer:
		isReady = true
		timer = 0
		readySilos.emit(self)
		
func restartSilos():
		isReady = false
