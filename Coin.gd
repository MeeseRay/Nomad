extends Area2D

var coinname = Global.coinname
signal coin_collected
@onready var player = $"../Player"

func _ready():
	coinname = self.name
func _on_body_entered(body: CharacterBody2D):
	if body == player:
		$AnimationPlayer.play("bounce") #bounce action
		emit_signal("coin_collected")
		print(coinname)
		set_collision_mask_value(1,false)
		Global.collectedcoin.append(coinname)
	
func _on_animation_player_animation_finished(_anim_name):
	queue_free()
	#when bounce animation finishes, coin disappear. 
	#and this is the group of codes does that 


