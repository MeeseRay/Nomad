extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Rest_Timer()



var seconds = 0
var minutes = 0
var Default_seconds = 10
var Default_minutes = 0
func _on_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes-= 1
			seconds = 60
			
	seconds -= 1
	
	
	$Label.text = str(minutes) + ":" + str(seconds)
	
	if seconds == 0 and minutes == 0:
		get_tree().change_scene_to_file("res://time_over_screen.tscn")
	
	
func Rest_Timer():
	seconds = Default_seconds
	minutes = Default_minutes
