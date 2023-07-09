extends CharacterBody2D

var gravity = 10
var speed = 150
var can_shoot = true
var hp = 3
var damage_taken = 0
var shot_collision = ''
var can_damage = true

signal player_damage()

func _ready():
	self.add_collision_exception_with($Projectile)
	

func _physics_process(delta):
	if hp<=0:
		queue_free()
	velocity.y += gravity
	move_and_slide()
	shoot()



func shoot():
	var root_node = get_parent()
	var player = root_node.get_node('Player')
	var distance_from_player = global_position.distance_to(player.global_position)
	var direction = $Projectile.global_position.direction_to(player.global_position)
	var look = self.global_position.direction_to(player.global_position)
	if distance_from_player<500 and can_shoot==true:
		can_shoot = false
		$Projectile.velocity = direction*speed
		$Projectile/Timeout.start()
		if can_damage == true and shot_collision=='Player':
			player_damage.emit()
			can_damage = false
		elif shot_collision=='Sword':
			print('here')
	if look.x>0:
		get_node("MushroomSprite").set_flip_h(true)
		get_node("Projectile/ProjectileSprite").set_flip_h(true)
	else:
		get_node('MushroomSprite').set_flip_h(false)
		get_node("Projectile/ProjectileSprite").set_flip_h(false)

	

func _on_timeout_timeout():
	$Projectile.position = Vector2(0,0)
	$Projectile.velocity = Vector2(0,0)
	$Projectile.set_visible(false)
	$Projectile/Timeout2.start()


func _on_timeout_2_timeout():
	$Projectile.set_visible(true)
	can_shoot = true
	can_damage = true


func _on_sword_attack(damage):
	damage_taken = damage


func _on_sword_body_entered(body):
	print(hp)
	hp-=damage_taken
	can_shoot=false
	$MushroomSprite.play('hurt')
	$Projectile/Timeout2.start()


func _on_projectile_collided_with(object):
	shot_collision = object
