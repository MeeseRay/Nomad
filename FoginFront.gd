extends Sprite2D

@export var layer = 1
var speedoffset = 0.025
@onready var camera = $"../../Camera2D"

var posOffset : Vector2

func _ready():
	posOffset = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if camera:
		var targetPosition = -camera.global_transform.origin * layer * speedoffset + posOffset
		position += (targetPosition - position)  # Adjust the interpolation factor for smoother or faster blending
	else:
		print("Camera node not found.")

	if position.x - camera.global_transform.origin.x > 2968:
		posOffset.x -= 5936
	if position.x - camera.global_transform.origin.x < -2968:
		posOffset.x += 5936
