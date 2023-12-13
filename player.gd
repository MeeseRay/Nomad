extends CharacterBody2D

# Variables
var kunai = preload("res://kunai.tscn")
var Health = 3

@export var DashSpeed : float = 900.0
@export var WalkSpeed : float = 200.0
@export var RunSpeed : float = 400.0

var CanDoubleJump = true
var CanCoyoteJump = false
@export var JumpHeight : float = 100.0
@export var TimeToPeak : float = 0.4
@export var TimeToFall : float = 0.25
@export var JumpVelocity : float = ((2.0 * JumpHeight) / TimeToPeak) * -1.0
@export var JumpGravity : float = ((-2.0 * JumpHeight) / (TimeToPeak * TimeToPeak)) * -1.0
@export var FallGravity : float = ((-2.0 * JumpHeight) / (TimeToFall * TimeToFall)) * -1.0

var Speed
var CanDash = true

var facing_direction: Vector2 = Vector2.RIGHT
var direction = Input.get_axis("move_left", "move_right")
var previous_direction
var recent_health = Global.health


func _physics_process(delta):
	# Implements gravity.
	velocity.y += GetGravity() * delta
	direction = Input.get_axis("move_left", "move_right")
	var facing_direction: Vector2 = Vector2.RIGHT
	# Handles Jump.
	Jump()
	# Handles Sprinting.
	Sprint()
	# Handles Movement.
	Move()
	# Handles Dash.
	Dash(direction)
	# Handles Shooting.
	Shoot(direction)
	# Used for Coyote Jump.
	var WasOnFloor = is_on_floor()
	if Global.health < recent_health:
		knockback()
	move_and_slide()
	var JustLeftLedge = WasOnFloor and !is_on_floor() and velocity.y >= 0
	if JustLeftLedge:
		CanCoyoteJump = true
		$CoyoteTime.start()
	
# Handles Jump input. 
func Jump():
	if is_on_floor() or CanCoyoteJump:
		if Input.is_action_just_pressed("jump"):
			CanDoubleJump = true
			velocity.y = JumpVelocity
	elif CanDoubleJump and !is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JumpVelocity
			CanDoubleJump = false
	if Input.is_action_just_released("jump") and velocity.y < 0:
		$JumpTimer.start()
			
# Returns neccessary gravity.
func GetGravity():
	if velocity.y < 0.0:
		return JumpGravity
	else:
		return FallGravity
	
# Handles left and right input. 
func Move():
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		previous_direction = direction 
	velocity.x = direction * Speed
		#handles h.flip
	if direction != 0:
		facing_direction.x = direction
		$AnimatedSprite2D.flip_h = direction < 0
		velocity.x = direction * Speed
	else:
		velocity.x = 0

# Handles sprint input. 
func Sprint():
	if Input.is_action_pressed("sprint"):
		Speed = RunSpeed
	else:
		Speed = WalkSpeed
	
# Handles dash input. 
func Dash(direction):
	if Input.is_action_just_pressed("dash") and CanDash:
		velocity.x = DashSpeed * direction
		$DashTimer.start()
		CanDash = false
		$DashCooldown.start()
		
func Shoot(direction):
	if Input.is_action_just_pressed("shoot"):
		#$AnimatedSprite2D.play("Attack")
		var k = kunai.instantiate()
		if direction > 0:
			k.start($Muzzle.global_position, direction, previous_direction)
			previous_direction = direction
		elif direction < 0:
			k.start($Muzzle2.global_position, direction, previous_direction)
			previous_direction = direction
		elif direction == 0:
			if previous_direction > 0:
				k.start($Muzzle.global_position, previous_direction, direction)
			elif previous_direction < 0:
				k.start($Muzzle2.global_position, previous_direction, direction)
				
		get_tree().root.add_child(k)

func knockback():
	var knockbackdirection = -velocity.x
	velocity.x = knockbackdirection * 7
	move_and_slide()
	recent_health = Global.health
	


func _on_dash_timer_timeout():
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = DashSpeed / direction
func _on_dash_cooldown_timeout():
	CanDash = true
func _on_coyote_time_timeout():
	CanCoyoteJump = false
func _on_jump_timer_timeout():
	velocity.y = -100

	
func is_player() -> bool:
	return true


