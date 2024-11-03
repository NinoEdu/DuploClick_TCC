extends Area2D

var velocidade_queda = 200  # Velocidade com que a fruta cai
var toque_unico = false
var toque_contador=0
# Referência ao Timer adicionado manualmente
var tempo_ultimo_toque = 0.0
const LIMIAR_TOQUE_DUPLO = 0.6  # Tempo máximo (em ms) para considerar duplo toque

func _ready():
	pass

func _process(delta):
	# Atualiza o tempo desde o último toque
	if toque_contador > 0:
		tempo_ultimo_toque += delta
		
	position.y += velocidade_queda * delta  # Faz a fruta descer
	if self.is_in_group("escolhido"):
		if position.y > 1080:
			#await get_tree().create_timer(0.6).timeout 
			Global.vidas_perdidas += 1
			print("sou escolhido e ngm clicou em mim")
			queue_free()
			
	else:
		if position.y > 1080:
			queue_free()
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.is_pressed():
			if toque_contador >= 1 and tempo_ultimo_toque <= LIMIAR_TOQUE_DUPLO:		
				toque_contador = 0 #reseta essa merda
				tempo_ultimo_toque = 0.0  # Reseta o tempo
				toque_duplo_achado()
			else:
				#Primeiro toque detectado ou tempo limite excedido
				toque_contador +=1
				tempo_ultimo_toque = 0.0
				
				
func toque_duplo_achado():
	if self.is_in_group("inimigos"):
		print("sou inimigo")
		Global.vidas_perdidas += 1
		queue_free()
	elif self.is_in_group("escolhido"):
		print("escolhido")
		Global.contador_de_escolhidos += 1
		queue_free()
