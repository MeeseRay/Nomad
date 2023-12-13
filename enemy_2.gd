extends CharacterBody2D

@onready var player = $"../Player"
var speed = 120.0
var recent_health = Global.health

func _physics_process(delta):
	var player_position = player.global_position
	var enemy_position = global_position
	velocity = position.direction_to(player_position) * speed
	if Global.health < recent_health:
		knockback()
	move_and_slide()

func knockback():
	var knockbackdirection = -velocity.x
	velocity.x = knockbackdirection * 7
	move_and_slide()
	recent_health = Global.health
	
func _on_timer_timeout():
	pass
