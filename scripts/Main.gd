extends Node2D

onready var candys = $background/candys

var balao = preload("res://scenes/balao.tscn")
var ponto = preload("res://scenes/ponto.tscn")

var valor_balao
var novo_balao
var novo_ponto

var valores = [20, 20, 30, 50, 80, 80, 80, 120, 200, 0]
var framesEatCandy

func _ready():
	randomize()
	$loop_espera.play()
	framesEatCandy = int(rand_range(0,3))
	if candys != null:
		for candy in candys.get_children():
			novo_ponto = ponto.instance()
			valor_balao = novo_ponto.shuffle_valor(valores)
			valor_balao = valores
			novo_ponto.get_child(0).text = str(valor_balao[0])
			novo_balao = balao.instance()
			novo_balao.set_id(candy.name.substr(5, 2))
			candy.add_child(novo_balao)
			candy.add_child(novo_ponto)
			if novo_ponto.get_child(0).text == str(0):
				novo_ponto.get_child(0).text = ""
				candy.get_child(0).animation = "eatCandy"
				candy.get_child(0).frame = framesEatCandy
			valor_balao.remove(0)

func fim_de_jogo():
	Global.fimdejogo = true
	for candy in candys.get_children():
		for children in candy.get_children():
			if children.name == "balao":
				children.get_child(0).animation = "balao"+str(children.id)+"_sumindo"
	
func _on_tempo_espera_balao():
	Global.tempo_espera = 1
	$tempo_espera.set_wait_time(2)
	$tempo_espera.start()

func _on_tempo_espera_timeout():
	Global.tempo_espera = 0
