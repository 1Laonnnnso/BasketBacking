extends Control

# Hier den Pfad zu deiner Ziel-Szene in Anführungszeichen eintragen
const TARGET_SCENE_PATH = "res://scenes/world.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Diese Funktion lädt die neue Szene
func load_new_scene() -> void:
	get_tree().change_scene_to_file(TARGET_SCENE_PATH)


func _on_button_pressed() -> void:
	load_new_scene()
