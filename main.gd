extends Node2D
@export var quadrado_scene: PackedScene 
@export var circulo_scene: PackedScene 
@export var triangulo_scene: PackedScene 
@export var estrela_scene: PackedScene 
@onready var timer_geral = $TimerGeral 
@onready var timer_escolhido = $TimerEscolhido  # Timer para morangos
var tempo_ultimo_toque = 0
const LIMIAR_TOQUE_DUPLO = 300  # Tempo máximo (em ms) para considerar duplo toque
var ultima_posicao_objeto = Vector2.ZERO 
var distancia_minima = 280 
var inimigos = []
var escolhido 
var objetos = []
var q_inicial = 0
var vidas_iniciais = 0
var pause_inicial = true

@onready var q_escolhidos = Label
@onready var estrela_w = Sprite2D
@onready var triangulo_w = Sprite2D
@onready var circulo_w = Sprite2D
@onready var quadrado_w = Sprite2D

var widget = Sprite2D
var but_ini = Button
var zero_vidas = Sprite2D
var uma_vidas = Sprite2D
var duas_vidas = Sprite2D
var tres_vidas = Sprite2D

@onready var circulo_i = Sprite2D
@onready var quadrado_i = Sprite2D
@onready var triangulo_i = Sprite2D
@onready var estrela_i = Sprite2D
@onready var pause_layer = Control
@onready var pause_game = Control

@onready var music = AudioStreamPlayer
@onready var click = AudioStreamPlayer


var nome = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pause_layer = $Control
	pause_game = $pause
	
	estrela_w = $Control/estrela_w
	quadrado_w = $Control/quadrado_w
	triangulo_w = $Control/triangulo_w
	circulo_w = $Control/circulo_w
	
	q_escolhidos = $q_escolhidos
	but_ini = $Control/Button
	
	zero_vidas = $zero_vidas
	uma_vidas = $uma_vidas
	duas_vidas = $duas_vidas
	tres_vidas = $tres_vidas
	
	circulo_i = $circulo_i
	quadrado_i = $quadrado_i
	estrela_i = $estrela_i
	triangulo_i = $triangulo_i
	
	music = $music
	click = $click
	
	q_inicial = Global.contador_de_escolhidos
	vidas_iniciais = Global.vidas_perdidas
	objetos = [circulo_scene,quadrado_scene,triangulo_scene,estrela_scene]
	
	if Global.reset == true:
		print("entou aqui")
		var vetor_reset = Global.ultimo_escolhido
		escolhido = vetor_reset[0]
		inimigos= vetor_reset.slice(1,vetor_reset.size())
		escolhe_icone()
		pausado()
		timer_geral.one_shot = false
		timer_geral.wait_time = 3
		timer_geral.start()
		timer_geral.timeout.connect(self._on_timer_geral_timeout)
	
		timer_escolhido.one_shot = false
		timer_escolhido.wait_time = 4
		timer_escolhido.start()
		timer_escolhido.timeout.connect(self._on_timer_escolhido_timeout)
		reinicia_global()
		print("saiu")
	else:
		print("nada de global")
		reinicia_global()
		objetos.shuffle()
		escolhido = objetos[0]
		inimigos= objetos.slice(1,objetos.size())
		var v_embaralhado = objetos
		Global.ultimo_escolhido = v_embaralhado
		escolhe_icone()
		
		pausado()
		
		timer_geral.one_shot = false
		timer_geral.wait_time = 3
		timer_geral.start()
		timer_geral.timeout.connect(self._on_timer_geral_timeout)
		
		timer_escolhido.one_shot = false
		timer_escolhido.wait_time = 4
		timer_escolhido.start()
		timer_escolhido.timeout.connect(self._on_timer_escolhido_timeout)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.contador_de_escolhidos != q_inicial:
		q_escolhidos.text = str(Global.contador_de_escolhidos)
		q_inicial = Global.contador_de_escolhidos
		
	elif Global.vidas_perdidas != vidas_iniciais:
		if Global.vidas_perdidas < 3:
			atualiza_vidas(Global.vidas_perdidas)
		else:
			game_over()
		
func escolhe_icone() -> void:
	#print("Escolhido:", escolhido)  # Para verificar qual objeto foi escolhido
	for objeto in objetos:
		# Verifica se o objeto atual é o escolhido
		if objeto == escolhido:
			match objeto:
				circulo_scene:
					circulo_i.visible = true
				quadrado_scene:
					quadrado_i.visible = true
				triangulo_scene:
					triangulo_i.visible = true
				estrela_scene:
					estrela_i.visible = true
			break  # Sai do loop após encontrar o escolhido
			
func _on_timer_geral_timeout() -> void:
	gerar_inimigos()

func _on_timer_escolhido_timeout() -> void:
	gerar_escolhido()
	
func gerar_escolhido():
	var posicao_de_spawn = randf_range(258, 1688)
	while abs(posicao_de_spawn - ultima_posicao_objeto.x) < distancia_minima:
		posicao_de_spawn = randf_range(258, 1688)
	var novo_escolhido = escolhido.instantiate()
	novo_escolhido.position = Vector2(posicao_de_spawn, -80)
	add_child(novo_escolhido)
	novo_escolhido.add_to_group("escolhido")
	
func gerar_inimigos():
	inimigos.shuffle()
	var posicao_de_spawn = randf_range(258, 1688)
	while abs(posicao_de_spawn - ultima_posicao_objeto.x) < distancia_minima:
		posicao_de_spawn = randf_range(258, 1688)
	var novo_inimigo = inimigos[0].instantiate()
	novo_inimigo.position = Vector2(posicao_de_spawn, -80)
	add_child(novo_inimigo)
	ultima_posicao_objeto = novo_inimigo.position
	novo_inimigo.add_to_group("inimigos")
	
func atualiza_vidas(quantidade):
	match (quantidade):
		1:
			tres_vidas.visible = false
		2:
			duas_vidas.visible = false
		3:
			uma_vidas.visible = false

func pausado():
	#print("Escolhido:", escolhido)  # Para verificar qual objeto foi escolhido
	for objeto in objetos:
		# Verifica se o objeto atual é o escolhido
		if objeto == escolhido:
			match objeto:
				circulo_scene:
					circulo_w.visible = true
					nome = "circulo"
				quadrado_scene:
					quadrado_w.visible = true
					nome = "quadrado"
				triangulo_scene:
					triangulo_w.visible = true
					nome = "triangulo"
				estrela_scene:
					estrela_w.visible = true
					nome = "estrela"
	pause_layer.visible = true
	get_tree().paused = true

func game_over():
	uma_vidas.visible = false
	Global.nome_escolhido = nome
	print(Global.nome_escolhido)
	
	get_tree().change_scene_to_file("res://game_over.tscn")

func reinicia_global():
	Global.contador_de_escolhidos = 0
	Global.vidas_perdidas = 0
	Global.nome_escolhido = ""

func _on_pause_but_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.1).timeout
	pause_game.visible = true
	get_tree().paused = true

func _on_button_pressed() -> void:
	click.play()
	pause_layer.visible = false
	get_tree().paused = false

func _on_play_pause_pressed() -> void:
	click.play()
	pause_game.visible = false
	get_tree().paused = false

func _on_reset_pause_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.2).timeout
	Global.reset = true
	pause_game.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")


func _on_sair_pause_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.15).timeout
	Global.reset = false
	pause_game.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://start_game.tscn")
