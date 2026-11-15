extends Node2D

@export var enemy_scene: PackedScene
@export var left_spawn_marker: Marker2D
@export var right_spawn_marker: Marker2D

var total_spawned: int = 0
var left_spawned: int = 0
var right_spawned: int = 0

const MAX_TOTAL: int = 200
const MAX_SIDE: int = 100

@onready var timer: Timer = $Timer

func _ready() -> void:
	# Timer auf 10 Sekunden einstellen und starten
	timer.wait_time = 10.0
	timer.one_shot = false
	timer.timeout.connect(_on_spawn_timer_timeout)
	timer.start()

func _on_spawn_timer_timeout() -> void:
	# Wenn insgesamt 100 Gegner erreicht sind, stoppen wir den Timer
	if total_spawned >= MAX_TOTAL:
		timer.stop()
		print("Alle 100 Gegner wurden erfolgreich gespawnt!")
		return

	var spawn_left = false
	var spawn_right = false

	# Entscheiden, welche Seite spawnt
	if left_spawned < MAX_SIDE and right_spawned < MAX_SIDE:
		# Beide Seiten haben noch Platz -> Zufällig wählen
		if randf() < 0.5:
			spawn_left = true
		else:
			spawn_right = true
	elif left_spawned < MAX_SIDE:
		# Nur die linke Seite hat noch Platz
		spawn_left = true
	elif right_spawned < MAX_SIDE:
		# Nur die rechte Seite hat noch Platz
		spawn_right = true

	# Gegner an der entsprechenden Position erzeugen
	if spawn_left:
		spawn_enemy(left_spawn_marker.global_position)
		left_spawned += 1
		total_spawned += 1
		print("Gegner links gespawnt. Gesamt: ", total_spawned)
	elif spawn_right:
		spawn_enemy(right_spawn_marker.global_position)
		right_spawned += 1
		total_spawned += 1
		print("Gegner rechts gespawnt. Gesamt: ", total_spawned)

func spawn_enemy(pos: Vector2) -> void:
	if not enemy_scene:
		print("Fehler: Keine Enemy Scene zugewiesen!")
		return
		
	var enemy = enemy_scene.instantiate()
	enemy.global_position = pos
	get_tree().current_scene.add_child(enemy)
