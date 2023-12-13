extends Area2D

var speed = 1500


func _process(delta):
	position += delta * speed
	



func _on_body_entered(body):
	#body.queue_free()
	pass
