extends CharacterBody2D

@onready var player: CharacterBody2D = %Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var speed_label: Label = $Speed_label
@onready var lava: Area2D = %lava

const SPEED = 150
var NEW_SPEED
const JUMP_VELOCITY = -300.0
var lava_distance
var log_lava_distance

func calculate_death_distance():
	lava_distance = player.position.x - lava.position.x
	log_lava_distance = log(lava_distance)
	#print(log_lava_distance)
	return int(log_lava_distance)

#func _process(delta: float) -> void:
	#Change player speed based on distance from "lava"
	#SPEED -= calculate_death_distance()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Defines directino based on input. right = 1, left = -1, nothing  = 0
	var direction := Input.get_axis("left", "right")
	
	#Change player speed based on distance from "lava"
	if calculate_death_distance() == 2:
		NEW_SPEED = 250
	elif calculate_death_distance() == 3:
		NEW_SPEED = 150
	elif calculate_death_distance() == 4:
		NEW_SPEED = 30
	else:
		NEW_SPEED = 10
	
	#NEW_SPEED = SPEED ** (1/ (calculate_death_distance() + 0.00000000001)) 
	#print(calculate_death_distance())
	speed_label.text = "SPEED: " + str(NEW_SPEED)
		
	#Flips Player
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
		
	#Change Animation
	if  is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	#Apply direction & move
	if direction:
		velocity.x = direction * NEW_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, NEW_SPEED)
		
		

	move_and_slide()

	

	
	
