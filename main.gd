extends Node

var portal_fade_duration = 0.05
var portal_fade_timer = portal_fade_duration
var portal_animation_player
var directional_light_2d
var track

func _ready():

	portal_animation_player = $Portal/CanvasLayer/AnimationPlayer
	directional_light_2d = $DirectionalLight2D
	track = $maintrack
	track.play()
	print(Global.collectedcoin)
	if Global.coinname in Global.collectedcoin:
		queue_free()
func _process(delta):
	if portal_fade_timer > 0:
		portal_fade_timer -= delta

		if portal_fade_timer <= 0:
			# Start the fade-out animation on the portal
			portal_animation_player.play("fade_out")

# This function is called when a body enters the CollisionShape2D
func _on_collision_shape_2d_body_entered(body):
	if body.name == "Player":  # Replace "Player" with the name of your player node
		# Adjust the directional light intensity when the player enters
		directional_light_2d.energy = 0.5  # Set the desired intensity

# This function is called when a body exits the CollisionShape2D
func _on_collision_shape_2d_body_exited(body):
	if body.name == "Player":
		# Reset the directional light intensity when the player exits
		directional_light_2d.energy = 1.0  # Set it back to the original intensity




