extends Node2D
@onready var click_ini

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	click_ini = $click


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	click_ini.play()
	await get_tree().create_timer(0.15).timeout 
	get_tree().change_scene_to_file("res://main.tscn")
