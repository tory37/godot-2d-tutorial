extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()

	# Show game over and update the score.
	$HUD.show_game_over()

func new_game() -> void:
	print_debug("New game")
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$ScoreTimer.start()
	$MobTimer.start()
	$Music.play()
	$HUD.show_message("Get Ready")
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	score += 1

func _on_score_timer_timeout() -> void:
	print_debug("Score timer timeout", score)
	score += 1
	$MobTimer.start()
	$ScoreTimer.start()

	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the path to spawn the mob at.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 200.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
