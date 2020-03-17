extends KinematicBody2D

export var UP = "Player1_up"
export var DOWN = "Player1_down"
export var LEFT = "Player1_left"
export var RIGHT = "Player1_right"
export var ANIMATION = "res://Player1_ANIMATION.tres"

var vel = Vector2()
const ACCEL = 800
const DECCEL = 800
const MAX_SPEED = 400
const GRAVITY = 25
const JUMP_HEIGHT = 900
const UP_DIRECTION = Vector2(0,-1)

var spawnpoint:Vector2

func _ready():
	spawnpoint = position
	$AnimatedSprite.frames = load(ANIMATION)

func _process(delta):
	vel.y += GRAVITY
	
	if(Input.is_action_pressed(LEFT)):
		vel.x += -ACCEL
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
		
	elif(Input.is_action_pressed(RIGHT)):
		vel.x += ACCEL
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
		
	else:
		if is_on_floor():
			vel.x = lerp(0, vel.x, 0.2)
			$AnimatedSprite.play("Idle")
		else:
			vel.x = lerp(0, vel.x, 0.05)
	
	if is_on_floor():
		if Input.is_action_pressed(UP):
			vel.y = -JUMP_HEIGHT
	else:
		$AnimatedSprite.play("Jump")
		
	vel.x = clamp(vel.x,-MAX_SPEED,MAX_SPEED)
	vel.y = clamp(vel.y,-MAX_SPEED-JUMP_HEIGHT,MAX_SPEED)
	
	
	vel = move_and_slide(vel, UP_DIRECTION)


func _on_player_hit(body):
	if body is KinematicBody2D:
		position = spawnpoint
		print("Player Dies")

