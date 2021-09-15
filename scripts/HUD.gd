extends Node2D

var pontuacao1 = Global.pontos1
var pontuacao2 = Global.pontos2

onready var labelPontuacao1 = $ponto1/pontuacao1
onready var labelPontuacao2 = $ponto2/pontuacao2

var teste = 0

func atualizaPontuacao1(pontosRecebidos):
	update_pontuacao(int(labelPontuacao1.text), (pontosRecebidos + int(labelPontuacao1.text)), labelPontuacao1)
	
func atualizaPontuacao2(pontosRecebidos):
	update_pontuacao(int(labelPontuacao2.text), (pontosRecebidos + int(labelPontuacao2.text)), labelPontuacao2)

func update_pontuacao(current, target, label):
	print("currente: " + str(current))
	print("target: " + str(target))
	var increment = target / 10
	
	while (current < target):
		current += increment
		yield(get_tree().create_timer(0.0001),"timeout")
		label.text = str(current)
	while (current > target):
		current -= 1
		yield(get_tree().create_timer(0.00001),"timeout")
		label.text = str(current)
	
