extends CanvasLayer


func _ready():
	$Coins.text = str(Global.coins)
	

func _on_coin_collected():
	Global.coins = Global.coins + 1
	_ready()
	#counting up, update the value
	if Global.coins == 12:
		get_tree().change_scene_to_file("res://youwin.tscn")


func _on_player_body_entered(body):
	if body.is_in_group("Enemies"):
		Global.health = Global.health - 1
		$HBoxContainer.update_health(Global.health)
		if Global.health == 0:
			get_tree().change_scene_to_file("res://youlose.tscn")
		
