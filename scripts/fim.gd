extends Node2D



func _ready() -> void:
	$score.text = str(Global.score)
	$objeto.texture = load(Global.objeto_escolhido)


func _on_voltar_inicio_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")


func _on_recomecar_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/objeto_escolhido.tscn")


func _on_recomecar_2_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/objeto_escolhido.tscn")
