extends Node2D





func _on_button_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/objeto_escolhido.tscn")
