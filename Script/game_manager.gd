extends Node2D

@export var shootControllerScene : PackedScene
@export var spawnEnemyRocketsScene : PackedScene

var shootController
var spawnEnemyRockets 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shootController = shootControllerScene.instantiate()
	spawnEnemyRockets = spawnEnemyRocketsScene.instantiate()
	
	add_child(shootController)
	add_child(spawnEnemyRockets)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
