extends Node

var array_objetos = ["res://assets/objetos/quadrado_amarelo.png",
	"res://assets/objetos/quadrado_ciano.png", "res://assets/objetos/triangulo_azul.png", 
	"res://assets/objetos/triangulo_laranja.png", "res://assets/objetos/estrela_verde.png",
	"res://assets/objetos/estrela_vermelha.png", "res://assets/objetos/bola_vermelha.png",
	"res://assets/objetos/bola_azul.png"]

var objeto_escolhido

var score = 0

func nivel_2():
	array_objetos.append("res://assets/objetos/quadrado_roxo.png")
	array_objetos.append("res://assets/objetos/triangulo_rosa.png")
	array_objetos.append("res://assets/objetos/estrela_amarela.png")
	array_objetos.append("res://assets/objetos/bola_verde.png")


func nivel_3():
	array_objetos.append("res://assets/objetos/quadrado_vermelho.png")
	array_objetos.append("res://assets/objetos/triangulo_verde.png")
	array_objetos.append("res://assets/objetos/estrela_ciana.png")
	array_objetos.append("res://assets/objetos/bola_amarela.png")
