extends Area2D

@export var radiusTexture = 32
@export var maxRadius = 300
@export var expansionSpeed = 300

var currentRadius = 0
@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var circleShape = collisionShape.shape as CircleShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentRadius = 0
	sprite.scale = Vector2.ZERO
	circleShape.radius = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentRadius += expansionSpeed * delta
	
	var scaleValue = currentRadius/radiusTexture
	sprite.scale = Vector2(scaleValue, scaleValue)
	circleShape.radius = currentRadius
	
	var bodiesInRadius = get_overlapping_bodies()
	for body in bodiesInRadius:
		if body.has_method("explode"):
			body.explode()
	
	if currentRadius >= maxRadius:
		queue_free()
