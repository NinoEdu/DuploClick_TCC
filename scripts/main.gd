extends Node2D

var vidas = 3

var pause_scene

var objeto = preload("res://scenes/objeto.tscn")
var tempo = 0

func _ready() -> void:
	Global.score = 0
	$objeto.texture = load(Global.objeto_escolhido)

#spawn dos objetos
func _on_timer_timeout() -> void:
	var instanciar_objeto = objeto.instantiate()
	Global.array_objetos.shuffle()
	instanciar_objeto.objeto = Global.array_objetos[0]
	instanciar_objeto.get_node("objeto").texture = load(Global.array_objetos[0])
	spawn_objetos(instanciar_objeto)


func _on_spawn_certo_timeout() -> void:
	var instanciar_objeto = objeto.instantiate()
	instanciar_objeto.objeto = Global.objeto_escolhido
	instanciar_objeto.get_node("objeto").texture = load(Global.objeto_escolhido)
	#tenta garantir que os objetos não tenham spawn na mesma posição
	await get_tree().create_timer(randf_range(0.2, 0.5)).timeout
	spawn_objetos(instanciar_objeto)


func spawn_objetos(instanciar_objeto):
	instanciar_objeto.connect("acertou", Callable(self, "acertou"))
	instanciar_objeto.connect("errou", Callable(self, "errou"))
	instanciar_objeto.connect("fora_da_tela", Callable(self, "fora_da_tela"))
	
	var x_min = 260  # Limite esquerdo
	var x_max = get_viewport_rect().size.x - 260  # Limite direito
	instanciar_objeto.position = Vector2(randf_range(x_min, x_max), randf_range(5, -30))
	
	#conta tempo para ir aumentando a dificuldade
	tempo += 3.0
	
	if tempo > 60:
		instanciar_objeto.speed = randi_range(140,170)
	
	if tempo == 60:
		$timer_spawn.wait_time = 2.5
		Global.nivel_2()
	
	if tempo == 120:
		$timer_spawn.wait_time = 2.2
		Global.nivel_3()
	
	add_child(instanciar_objeto)




func acertou() -> void:
	Global.score += 1
	$score.text = str(Global.score)


func errou() -> void:
	vidas -= 1
	match vidas:
		2:
			$vidas.texture = load("res://assets/vidas/2_vidas.png")
		1:
			$vidas.texture = load("res://assets/vidas/1_vida.png")
		0:
			$vidas.texture = load("res://assets/vidas/0_vidas.png")
			await get_tree().create_timer(0.2).timeout
			get_tree().change_scene_to_file("res://scenes/fim.tscn")

func fora_da_tela() -> void:
	$negativo.play()
	errou()


func _on_pause_botao_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	pause_scene = load("res://scenes/pause.tscn").instantiate()
	add_child(pause_scene)
	get_tree().paused = true
