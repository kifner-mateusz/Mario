extends KinematicBody2D

export var ANIMATION = "res://Player1_ANIMATION.tres"

var vel = Vector2()
const ACCEL = 400
const DECCEL = 400
const MAX_SPEED = 200
const GRAVITY = 25
const JUMP_HEIGHT = 900
const UP_DIRECTION = Vector2(0,-1)

var move = Vector2(0,0)
var track_body:PhysicsBody2D

var spawnpoint:Vector2

func _ready():
	spawnpoint = position
	$AnimatedSprite.frames = load(ANIMATION)

func _process(delta):
	vel.y += GRAVITY
	
	if global_position.distance_to(track_body.global_position) < 500:
		move = global_position.direction_to(track_body.global_position)


	if(move.x<0):
		vel.x += -ACCEL
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
		
	elif(move.x>0):
		vel.x += ACCEL
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
		
	# else:
	# 	if is_on_floor():
	# 		vel.x = lerp(0, vel.x, 0.2)
	# 		$AnimatedSprite.play("Idle")
	# 	else:
	# 		vel.x = lerp(0, vel.x, 0.05)
	
	# if is_on_floor():
	# 	if Input.is_action_pressed(UP):
	# 		vel.y = -JUMP_HEIGHT
	# else:
	# 	$AnimatedSprite.play("Jump")
		
	vel.x = clamp(vel.x,-MAX_SPEED,MAX_SPEED)
	vel.y = clamp(vel.y,-MAX_SPEED-JUMP_HEIGHT,MAX_SPEED)
	
	
	vel = move_and_slide(vel, UP_DIRECTION)


func _on_player_hit(body):
	if body is KinematicBody2D:
		move = Vector2(0,0)
		print("Enamy Dies")
		set_collision_layer_bit(0,false)
		yield(get_tree(),"idle_frame")
		position = spawnpoint
		yield(get_tree(),"idle_frame")
		set_collision_layer_bit(0,true)

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D and (body.get_parent().name):
		track_body = body
