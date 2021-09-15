extends Node2D

signal tempo_espera_balao

onready var hud = get_node("/root/Main/HUD")
onready var candys = get_node("/root/Main/background/candys")
onready var main = get_node("/root/Main")

onready var animatedsprite
onready var animationBalao = $animation

var id
var pontosBalao
var pontuacao

func _ready():
	connect("tempo_espera_balao", main, "_on_tempo_espera_balao")

func set_id(valor_id):
	self.id = valor_id
	set_sprite(self.id)
	
func set_sprite(valor_id):
	animatedsprite = $Sprite
	animatedsprite.animation = "balao"+str(valor_id)+"_fechado"

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and Global.fimdejogo == false and Global.tempo_espera == 0:
		$apito.play()
		animationBalao.play("abrir")
		emit_signal("tempo_espera_balao")
		animatedsprite.animation = "balao"+str(id)+"_aberto"
		
		yield(animationBalao, "animation_finished") #Aguardar animação finalizar para dar continuidade ao código
		
		for child in self.get_parent().get_children():	
			if child.name == "ponto":
				pontuacao = int(child.get_child(0).text)
				if pontuacao == 0:
					self.get_parent().get_child(1).visible = true
					$erro.play()
					main.fim_de_jogo()
					Global.pontos1 = 0
					Global.pontos2 = 0
				else:
					$acerto.play()
					Global.pontos1 = pontuacao
					Global.pontos2 = pontuacao

		hud.atualizaPontuacao1(Global.pontos1)
		hud.atualizaPontuacao2(Global.pontos2)

		yield(get_tree().create_timer(0.5), "timeout")
		self.visible = false
		yield(get_tree().create_timer(2), "timeout")
		self.queue_free()
