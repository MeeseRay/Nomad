extends Area2D

var entered = false
var animation_player
var animation_player2
var transition_timer = 0
var transition_duration = 1.0
var canvas_layer
var texture_rect
var interaction_textbox
var sfx6

func _ready():
	animation_player = $AnimatedSprite2D
	animation_player2 = $CanvasLayer/AnimationPlayer
	canvas_layer = $CanvasLayer
	texture_rect = $CanvasLayer/TextureRect
	interaction_textbox = $RichTextLabel
	sfx6 = $sfx6
func _on_body_entered(_body: CharacterBody2D):
	entered = true
	print("body entered entrance")
	interaction_textbox.text = "PRESS F"
	interaction_textbox.visible = true

func _on_body_exited(_body: CharacterBody2D):
	entered = false
	print("body exited entrance")
	interaction_textbox.visible = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("interact2"):
			animation_player2.play("fade_in2")
			transition_timer = transition_duration
			sfx6.play()
	if transition_timer > 0:
		transition_timer -= delta
		
		if transition_timer <= 0:
			get_tree().change_scene_to_file("res://world_3.tscn")
