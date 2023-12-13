extends StaticBody2D

var is_open = false
var door_animation
var collision_shape
#var sfx
#var sfx2
#var sfx3

func _ready():
	door_animation = $AnimatedSprite2D
	collision_shape = $CollisionShape2D
	#sfx = $SoundOne
	#sfx2 = $SoundTwo
	#sfx3 = $SoundThree
	
func open_door():
	is_open = true
	door_animation.play("Open")
	#sfx.play()
	#sfx2.play()
	#sfx3.play()
	collision_shape.set_disabled(true)
	print("Door Opened")

func close_door():
	is_open = false
	door_animation.play("Closed")
	#sfx.play()
	#sfx2.play()
	collision_shape.set_disabled(false)
	print("Door Closed")
