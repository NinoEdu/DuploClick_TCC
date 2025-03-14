extends Area2D

var tempo_ultimo_clique = 0.0
var intervalo_duplo_clique = 0.4  # Tempo máximo

@export var objeto: String

@export var speed = 200  # Velocidade de queda

signal acertou
signal errou
signal fora_da_tela


func _process(delta):
	translate(Vector2(0, speed * delta))
	if position.y > 1080 and objeto == Global.objeto_escolhido:
		fora_da_tela.emit()
		queue_free()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		$click.play()
		$objeto/objeto_animacao.play("clique_objeto")
		var tempo_atual = Time.get_ticks_msec() / 1000.0
		if tempo_atual - tempo_ultimo_clique <= intervalo_duplo_clique:
			_on_double_click()
		tempo_ultimo_clique = tempo_atual


func _on_double_click():
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.1).timeout
	
	if objeto == Global.objeto_escolhido:
		acertou.emit()
		$acertou_audio.play()
		$acertou/acertou_animacao.play("animacao")
		
	else:
		errou.emit()
		$negativo.play()
		$errou/errou_animacao.play("animacao")
	
	await get_tree().create_timer(0.6).timeout 
	queue_free()
