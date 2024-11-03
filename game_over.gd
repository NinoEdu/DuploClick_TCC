extends Node2D
var quantidade = 0
var c = "circulo"
var q = "quadrado"
var t = "triangulo"
var e = "estrela"
var circulo_f = Sprite2D
var triangulo_f = Sprite2D
var quadrado_f = Sprite2D
var estrela_f = Sprite2D
var contador = Label
@onready var aplauso = AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quantidade = Global.contador_de_escolhidos
	contador = $contador
	circulo_f = $circulo_f
	quadrado_f = $quadrado_f
	triangulo_f = $triangulo_f
	estrela_f = $estrela_f
	aplauso = $aplauso
	atualiza_final()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func atualiza_final():
	contador.text = str(quantidade)
	match (Global.nome_escolhido):
		"circulo":
			circulo_f.visible = true
		"triangulo":
			triangulo_f.visible = true
		"estrela":
			estrela_f.visible = true
		"quadrado":
			quadrado_f.visible = true
			


func _on_quit_b_button_down() -> void:
	Global.reset = false
	get_tree().change_scene_to_file("res://start_game.tscn")


func _on_next_b_button_down() -> void:
	Global.reset = false
	get_tree().change_scene_to_file("res://main.tscn")


func _on_restart_b_button_down() -> void:
	Global.reset = true
	get_tree().change_scene_to_file("res://main.tscn")
