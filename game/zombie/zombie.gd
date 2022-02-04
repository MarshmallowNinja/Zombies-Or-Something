extends KinematicBody2D

var ZombieHealth : int = 10
var IsDead : bool = false
var walkspeed : int 
var velocity = Vector2.ZERO
var target = null

func _ready():
	walkspeed = randi() % 21 + 3
	print(var2str(walkspeed))
	pass 

func _process(delta):
	if $AnimatedSprite.is_playing() == true:
		pass
	if $AnimatedSprite.is_playing() == false:
		RemoveZombie()
	while $AnimatedSprite.frame == 16:
		$AnimatedSprite.play("2d flames")
		IsDead = true

func _physics_process(delta):
	velocity = Vector2.ZERO
	if target:
		velocity = position.direction_to(target.position) * walkspeed
	velocity = move_and_slide(velocity)
	
	if velocity.x <= -1:
		$AnimatedSprite.play("3b walkleft")
		
	if velocity.x >= 1:
		$AnimatedSprite.play("3a walkright")
		
	if velocity.x == 0:
		if IsDead == false:
			$AnimatedSprite.play("1a front")
		else:
			pass

func ExplodeDeath():
	if IsDead == true:
		pass
	if IsDead == false:
		$AnimatedSprite.play("2c explode")
		walkspeed = 0
	IsDead = true

func Death(cause : int):
	if cause == 0:
		IsDead = true
		$AnimatedSprite.play("2b death")
		walkspeed = 0
	if cause == 1:
		IsDead = true
		$AnimatedSprite.play("2b death")
		# Add some other zombie timeout stuff soon
		walkspeed = 0

func _on_Lifetime_timeout():
	Death(1)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if IsDead == false:
		if event.is_action_pressed("click"):
			Death(0)
			IsDead = true
	if IsDead == true:
		walkspeed = 0
		return

# Removes zombie from scene
func RemoveZombie():
	hide()
	queue_free()

# Removes already dead zombies from scene.
func _on_DeathCheck_timeout():
	if IsDead == true:
		RemoveZombie()

func _on_DetectRadius_body_entered(body):
	if body.is_in_group("human"):
		target = body
	else:
		return

#func _on_DetectRadius_body_exited(body):
#	target = null

func _on_Invinciibility_timeout():
	$ClicktoKill/clickcollision.disabled = false
