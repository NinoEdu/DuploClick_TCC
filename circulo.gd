extends Area2D

var velocidade_queda = 200  # Velocidade com que a fruta cai
var toque_unico = false
var toque_contador=0
# Referência ao Timer adicionado manualmente
var tempo_ultimo_toque = 0.0
const LIMIAR_TOQUE_DUPLO = 0.6  # Tempo máximo (em ms) para considerar duplo toque
var adiciona = Label
var remove = Label
func _ready():
	adiciona = $adiciona
	remove = $remove

func _process(delta):
	# Atualiza o tempo desde o último toque
	if toque_contador > 0:
		tempo_ultimo_toque += delta
		
	position.y += velocidade_queda * delta  # Faz a fruta descer
	if self.is_in_group("escolhido"):
		if position.y > 1080:
			$negativo.play()
			var posicao = self.global_position
			remove.global_position = posicao
			remove.visible = true
			$remove/adiciona_a.play("adiciona")
			await get_tree().create_timer(0.5).timeout 
			queue_free()
			adiciona_perca()
			

	else:
		if position.y > 1080:
			queue_free()
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.is_pressed():
			#$Sprite2D/circle_animacao.stop()
			$Sprite2D/circle_animacao.play("circle")
			$click.play()
			if toque_contador >= 1 and tempo_ultimo_toque <= LIMIAR_TOQUE_DUPLO:		
				toque_contador = 0 #reseta essa merda
				tempo_ultimo_toque = 0.0  # Reseta o tempo
				$click.stop()
				toque_duplo_achado()
			else:
				#Primeiro toque detectado ou tempo limite excedido
				toque_contador +=1
				tempo_ultimo_toque = 0.0
				
func toque_duplo_achado():
	if self.is_in_group("inimigos"):
		$negativo.play()
		var posicao = self.global_position
		remove.global_position = posicao
		print(remove.global_position)
		remove.visible = true
		$remove/adiciona_a.play("adiciona")
		Global.vidas_perdidas += 1
		await get_tree().create_timer(0.5).timeout 
		queue_free()
		
	elif self.is_in_group("escolhido"):
		$pegou.play()
		print("escolhido")
		var posicao = self.global_position
		adiciona.global_position = posicao
		print(adiciona.global_position)
		adiciona.visible = true
		$adiciona/adiciona_a.play("adiciona")
		Global.contador_de_escolhidos += 1
		await get_tree().create_timer(0.5).timeout 
		queue_free()
		
func adiciona_perca():
	Global.vidas_perdidas += 1
