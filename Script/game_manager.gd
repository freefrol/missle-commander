extends Node2D

@export var shootControllerScene : PackedScene
var shootController
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shootController = shootControllerScene.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
