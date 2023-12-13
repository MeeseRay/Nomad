extends CharacterBody2D

var speed = 750
@onready var player = $"../Player"


func start(_position, _direction, previous_direction):
	if _direction == 0:
		_direction = previous_direction
	position = _position
	velocity.x = speed * _direction
	previous_direction = _direction
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)



func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemies"):
		body.queue_free()
		queue_free()
	$Timer.start()


func _on_timer_timeout():
	queue_free()
