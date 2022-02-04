extends Node2D

var bombs : int = 1
var randomspawn : int = 0

func _ready():
	randomspawn = randi() % 100
	pass

func _process(delta):
	if Input.is_action_just_pressed("rightclick"):
		get_tree().call_group("zombie", "ExplodeDeath")
	else:
		pass

func _on_Timer_timeout():
	var scene = load("res://game/zombie/zombie.tscn")
	var zombie = scene.instance()
	randomspawn = randi() % 100
	
	if randomspawn <= 50:
		zombie.position = $zombiespawn.global_position
		print(var2str(randomspawn))
	
	if randomspawn >= 50:
		zombie.position = $otherzs.global_position
		print(var2str(randomspawn))
	
	add_child(zombie)
