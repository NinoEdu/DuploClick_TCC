extends Node

func _on_continuar_pressed() -> void:
	get_tree().paused = false
	$click.play()
	await get_tree().create_timer(0.15).timeout
	queue_free()


func _on_recomecar_pressed() -> void:
	get_tree().paused = false
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/objeto_escolhido.tscn")


func _on_voltar_tela_inicial_pressed() -> void:
	get_tree().paused = false
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
