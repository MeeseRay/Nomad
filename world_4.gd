extends Node2D

var portal_fade_duration = 0.05
var portal_fade_timer = portal_fade_duration
var portal_animation_player
var track

func _ready():
	portal_animation_player = $Portal4/CanvasLayer/AnimationPlayer # Adjust the path to your portal
	track = $CaveTrack
	track.play()
	
func _process(delta):
	
	if portal_fade_timer > 0:
		portal_fade_timer -= delta

		if portal_fade_timer <= 0:
			# Start the fade-out animation on the portal
			portal_animation_player.play("fade_out")
