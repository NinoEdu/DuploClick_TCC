extends Node



func _ready() -> void:
	Global.array_objetos.shuffle()
	$objeto.texture = load(Global.array_objetos[0])
	Global.objeto_escolhido = Global.array_objetos[0]


func _on_ok_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")
