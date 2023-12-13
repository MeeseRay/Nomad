extends Area2D

var door
var lev_animations
var is_interacting = false
var sfx1
var sfx2
var sfx3
var sfx4
var sfx5
var interaction_textbox

func _ready():
	#door reference and lever animations
	door = $Door
	lev_animations = $AnimatedSprite2D
	set_process_input(true)
	interaction_textbox = $RichTextLabel
	sfx1 = $sfx1
	sfx2 = $sfx2
	sfx3 = $sfx3
	sfx4 = $sfx4
	sfx5 = $sfx5
	
func _input(event):
	if is_interacting && event is InputEventKey && event.is_action_pressed("interact"):
		if door:
			if door.is_open:
				door.close_door()
				lev_animations.play("Activate")
				sfx1.play()
				sfx2.play()
				sfx3.play()
				sfx4.play()
				print("Button Off")
				
			else:
				door.open_door()
				lev_animations.play("Deactivate")
				sfx1.play()
				sfx2.play()
				sfx3.play()
				sfx5.play()
				print("Button On")
		
func _process(_delta):
	if is_interacting and Input.is_action_just_released("interact"):
		is_interacting = false
		interaction_textbox.visible = false

func _on_area_entered(area):
	# Check if the entering area is the player or whatever interacts with the lever
	if area.has_method("is_player") and area.is_player():
		is_interacting = true
		interaction_textbox.text = "PRESS E"
		interaction_textbox.visible = true
		print("body entered")
	
		
func _on_area_exited(area):
	# Check if the exiting area is the player or whatever interacts with the lever
	if area.has_method("is_player") and area.is_player():
		is_interacting = false
		interaction_textbox.visible = false
		print("body exited")
