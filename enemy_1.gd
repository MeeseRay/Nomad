extends CharacterBody2D


@export var speed : float = 120.0
@onready var player = $"../Player"
var facing_direction: Vector2 = Vector2.RIGHT

var RNG = RandomNumberGenerator.new()
var random_direction = RNG.randi_range(0,1)
var direction = random_direction
var movement = speed * direction
var grav = 2000

func _physics_process(delta):
	if direction != 0:
		facing_direction.x = direction
		$AnimatedSprite2D.flip_h = direction < 0
		velocity.x = direction * speed
	else:
		velocity.x = 0
		
	velocity.y = grav
	movement = speed * direction 
	velocity.x = movement
	if !is_on_floor():
		movement = -movement 
	move_and_slide()


func _on_timer_timeout():
	var player_position = player.global_position
	var enemy_position = global_position
	var distance_to_player = enemy_position.distance_to(player_position)
	
	if distance_to_player <= 150:
		if player_position >= enemy_position:
			direction = 1
		elif player_position < enemy_position:
			direction = -1
	elif distance_to_player > 150:
		random_direction = RNG.randi_range(0,1)
		direction = random_direction
		if direction == 0:
			direction = -1
		


func _on_area_2d_body_entered(body):
	if body == player: 
		pass
		
